Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTJaV7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 16:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTJaV7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 16:59:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32779 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263646AbTJaV7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 16:59:31 -0500
To: linux-kernel@vger.kernel.org
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: initrd help -- umounts root after pivot_root
Date: 31 Oct 2003 13:59:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bnulvd$fps$1@cesium.transmeta.com>
References: <1067604362.5526.15.camel@tweedy.ksc.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: H. Peter Anvin <hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Comment-To: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved

Followup to:  <1067604362.5526.15.camel@tweedy.ksc.nasa.gov>
By author:    Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
In newsgroup: linux.dev.kernel
> 
> John,
> 
> It does not appear that the kernel(s) will support the root fs on
> tmpfs.  Looking through the init kernel code:  It boils down to a block
> device with real major and minor number or NFS.
> 

Baloney.  See the SuperRescue CD, for example, for a distro which uses
exactly this.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
