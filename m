Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTDYT3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTDYT3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:29:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58884 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263695AbTDYT3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:29:20 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Fix SWSUSP & !SWAP
Date: 25 Apr 2003 12:41:07 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8c30j$tr3$1@cesium.transmeta.com>
References: <b8a2le$p88$1@cesium.transmeta.com> <CDEDIMAGFBEBKHDJPCLDMEBCDMAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <CDEDIMAGFBEBKHDJPCLDMEBCDMAA.hzhong@cisco.com>
By author:    "Hua Zhong" <hzhong@cisco.com>
In newsgroup: linux.dev.kernel
>
> It would be nice, so GRUB has no problem any more for using journaling file
> system on boot partition.
> 

Not just GRUB, but just about any boot loader which doesn't use
bmap().  bmap() is apparently special-cased in ext3, but still...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
