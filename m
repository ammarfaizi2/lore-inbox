Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269884AbRHEAox>; Sat, 4 Aug 2001 20:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269883AbRHEAod>; Sat, 4 Aug 2001 20:44:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15625 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269882AbRHEAoY>; Sat, 4 Aug 2001 20:44:24 -0400
Subject: Re: Error when compiling 2.4.7ac6
To: kiwiunixman@yahoo.co.nz (Matthew Gardiner)
Date: Sun, 5 Aug 2001 01:46:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Mr Kernel Dude)
In-Reply-To: <no.id> from "Matthew Gardiner" at Aug 05, 2001 12:25:29 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TC3V-0005hA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c check.c
> In file included from check.c:28:
> ldm.h:100: warning: `SYS_IND' redefined
> ldm.h:84: warning: this is the location of the previous definition
> ldm.h:104: warning: `NR_SECTS' redefined
> ldm.h:88: warning: this is the location of the previous definition
> ldm.h:109: warning: `START_SECT' redefined
> ldm.h:92: warning: this is the location of the previous definition
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> pipe -mpreferred-stack-boundary=2 -march=i686    -c -o msdos.o msdos.c
> rm -f partitions.o

Thanks - fixed 
