Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287381AbSAPT5g>; Wed, 16 Jan 2002 14:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287334AbSAPT5R>; Wed, 16 Jan 2002 14:57:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35851 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287368AbSAPT5M>; Wed, 16 Jan 2002 14:57:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Query about initramfs and modules
Date: 16 Jan 2002 11:56:59 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a24lub$4o9$1@cesium.transmeta.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <Pine.GSO.4.21.0201152226100.4339-100000@weyl.math.psu.edu> <20020116194121.GC32184@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020116194121.GC32184@codepoet.org>
By author:    Erik Andersen <andersen@codepoet.org>
In newsgroup: linux.dev.kernel
> 
> Keep in mind that insmod current needs to incorporate a full ELF
> interpreter in userspace (and the source code needs to know about
> all the types of relocations and jump for each arch and for 32
> and 64 bit ELF.  Horrible stuff really.  If we could cleanup the
> kernel's insmod implementation to require merely a syscall
> passing a filename to the kernel, it would sure make the
> initramfs smaller and simpler.  I believe Rusty made a patch to
> do this sort of thing....
> 

Yeah!  Let's put all this crap in KERNEL SPACE!  *NOT!*

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
