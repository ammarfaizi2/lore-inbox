Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTCDWth>; Tue, 4 Mar 2003 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTCDWth>; Tue, 4 Mar 2003 17:49:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264688AbTCDWtf>; Tue, 4 Mar 2003 17:49:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Loading and executing kernel from a non-standard address using
 SY SLINUX
Date: 4 Mar 2003 14:59:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b43b4r$i3t$1@cesium.transmeta.com>
References: <99F2150714F93F448942F9A9F112634CA54B07@txexmtae.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <99F2150714F93F448942F9A9F112634CA54B07@txexmtae.amd.com>
By author:    ravikumar.chakaravarthy@amd.com
In newsgroup: linux.dev.kernel
>
> I am trying to load and boot the kernel from a non-standard address
> (0x200000). I am using the SYSLINUX boot loader, which loads the
> kernel at that address. I have also made changes to the kernel to
> setup code and startup_32() function to effect the same. When I boot
> the system It says
> 

Modified, perhaps.  Stock SYSLINUX loads at the standard address
(0x100000).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
