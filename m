Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTDQUro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTDQUro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:47:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29708 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262627AbTDQUrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:47:43 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: problems booting 2.5 kernel, rh9
Date: 17 Apr 2003 13:59:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7n4iv$dub$1@cesium.transmeta.com>
References: <000501c3048d$a3e41700$0200a8c0@satellite> <20030417111714.GA16335@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030417111714.GA16335@wind.cocodriloo.com>
By author:    Antonio Vargas <wind@cocodriloo.com>
In newsgroup: linux.dev.kernel
> 
> Dave, since your ISP is blocking my mail, I reply on lkml...
> 
> I booted fine the 2.5 kernel by tagging it for netboot and
> then placing it on my tftp directory. I never use harddisk
> bootloaders, so if you can not make it work with grub,
> I would get ahead and make it boot from floppy. Yes, it
> takes a minute to load a kernel, but it works and is simple.
> 
> I use syslinux for that, it's fairly simple and you can
> enter kernel options directly at the boot prompt.
> 
> Also, since it's a dos 8.3-formatted floppy, you can upgrade
> your kernel by simply replacing the kernel file.
> 
> If you need a dos-formatted empty disk, I can post one to my
> homepage for you to download.
> 

Especially on recent 2.5, you can just "make bzdisk" and have it make
a syslinux floppy.  make bzdisk FDARGS='blah' lets you set the default
options right on the fly.  You need syslinux 2.02 or later (and, of
course, write permission to the floppy drive) if you want to do this
as non-root.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
