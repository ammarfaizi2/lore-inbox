Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317834AbSG1XNW>; Sun, 28 Jul 2002 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSG1XNW>; Sun, 28 Jul 2002 19:13:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8438 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317834AbSG1XNV>; Sun, 28 Jul 2002 19:13:21 -0400
Subject: Re: PROBLEM: ld error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bege <bege@inf.elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.31.0207282320470.22292-100000@pandora.inf.elte.hu>
References: <Pine.A41.4.31.0207282320470.22292-100000@pandora.inf.elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 01:32:09 +0100
Message-Id: <1027902729.808.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 22:22, bege wrote:
> make[3]: Entering directory `/usr/src/linux/drivers/char/drm'
> ld -m elf_i386 -r -o radeon.o radeon_drv.o radeon_cp.o radeon_state.o
> ld: BFD 2.12.90.0.1 20020307 Debian/GNU Linux internal error, aborting at ../../bfd/elflink.h line 6208 in elf_link_output_extsym
> 
> ld: Please report this bug.
        : 3060.53

This is a linker failure not a kernel problem. Can you report it to the
debian binutils maintainer.

