Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTFGVOF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 17:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbTFGVOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 17:14:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263743AbTFGVOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 17:14:02 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What are .s files in arch/i386/boot
Date: 7 Jun 2003 14:27:34 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bbtlc6$qtd$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0306072102580.1776-100000@jlap.stev.org> <6un0gty981.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <6un0gty981.fsf@zork.zork.net>
By author:    Sean Neakums <sneakums@zork.net>
In newsgroup: linux.dev.kernel
>
> James Stevenson <james@stev.org> writes:
> 
> >> > > What are .s files in arch/i386/boot, are they c sources of some sort?
> >> > > Where can I find the specifications documents they were made from? 
> >> > 
> >> > There are not c files.
> >> > They are assembler files
> >> > 
> >> > Try running gcc on a c file with the -S option
> >> > it will generate the same then you can tweak the
> >> > assembler produced to make it faster.
> >> > 
> >> Where can I find the .c files they were made from,
> >> and the spec sheets the .c files were made from? 
> >
> > You would have to find the original author of the person
> > who tweaks the assembler in the .s file chances are the .c
> > file is long gone though.
> 
> If there were ever C files to begin with.  It's not unheard-of for
> people to write assembler code from scratch.
> 

The ones in the Linux kernel were all written from scratch.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
