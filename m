Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTJVBFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTJVBFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:05:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46340 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263298AbTJVBFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:05:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 18:04:43 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bn4l3b$upe$1@cesium.transmeta.com>
References: <3F8E552B.3010507@users.sf.net> <bn42vk$ies$1@gatekeeper.tmr.com> <20031021212136.GA15043@hh.idb.hist.no> <bn4bav$ji4$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bn4bav$ji4$1@gatekeeper.tmr.com>
By author:    davidsen@tmr.com (bill davidsen)
In newsgroup: linux.dev.kernel
> 
> As noted, I do get around that... some care needs to be taken calling
> random number generators from threads, since some have internal storage
> in addition to the seed which can be provided by the caller.
> 

You can also put your stuff in Thread Local Storage.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
