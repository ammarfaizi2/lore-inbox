Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132407AbRDPXnJ>; Mon, 16 Apr 2001 19:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132414AbRDPXm7>; Mon, 16 Apr 2001 19:42:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31244 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132407AbRDPXmn>; Mon, 16 Apr 2001 19:42:43 -0400
Subject: Re: buz.c compile error
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 17 Apr 2001 00:44:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.21.0104161500450.3211-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Apr 16, 2001 03:01:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pIfO-0001Ez-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel 2.4.4-pre3.
> 
> gcc -D__KERNEL__ -I/home/marcelo/rpm/BUILD/kernel-2.4.3/linux/include
> -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> -pipe -mpreferred-stack-boundary=2 -march=i386 -DMODULE -DMODVERSIONS
> -include
> /home/marcelo/rpm/BUILD/kernel-2.4.3/linux/include/linux/modversions.h
> -c -o buz.o buz.c
> buz.c: In function `v4l_fbuffer_alloc':
> buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)

I dont plan to fix this. buz.c is sufficiently broken that I'll be submitting
Linus a patch to replace it with the generic Zoran driver once its been through
a clean up and maybe resynched with the work being done in their CVS tree

