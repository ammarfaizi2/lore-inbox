Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTDYUsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTDYUsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:48:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60172 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263998AbTDYUsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:48:54 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] i386 vsyscall DSO implementation
Date: 25 Apr 2003 14:00:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8c7m5$u3u$1@cesium.transmeta.com>
References: <3EA8942D.4050201@pobox.com> <200304250210.h3P2AoU12348@magilla.sf.frob.com> <16041.24730.267207.671647@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16041.24730.267207.671647@napali.hpl.hp.com>
By author:    David Mosberger <davidm@napali.hpl.hp.com>
In newsgroup: linux.dev.kernel
>
> I like this.  Even better would be if all platforms could do the same.
> I'm definitely interested in doing something similar for ia64 (the
> getunwind() syscall was always just a stop-gap solution).
> 
> I assume that these kernel ELF images would then show up in
> dl_iterate_phdr()?
> 
> To complete the picture, it would be nice if the kernel ELF images
> were mappable files (either in /sysfs or /proc) and would show up in
> /proc/PID/maps.  That way, a distributed application such as a remote
> debugger could gain access to the kernel unwind tables on a remote
> machine (assuming you have a remote filesystem).
> 

How about /boot?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
