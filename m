Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269891AbRHEBjk>; Sat, 4 Aug 2001 21:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269893AbRHEBjb>; Sat, 4 Aug 2001 21:39:31 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:45257 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269891AbRHEBjZ>; Sat, 4 Aug 2001 21:39:25 -0400
Message-Id: <5.1.0.14.2.20010805023727.03551570@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 05 Aug 2001 02:39:30 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Error when compiling 2.4.7ac6
Cc: kiwiunixman@yahoo.co.nz (Matthew Gardiner),
        linux-kernel@vger.kernel.org (Mr Kernel Dude)
In-Reply-To: <E15TC3V-0005hA-00@the-village.bc.nu>
In-Reply-To: <no.id>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:46 05/08/2001, Alan Cox wrote:
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c check.c
> > In file included from check.c:28:
> > ldm.h:100: warning: `SYS_IND' redefined
> > ldm.h:84: warning: this is the location of the previous definition
> > ldm.h:104: warning: `NR_SECTS' redefined
> > ldm.h:88: warning: this is the location of the previous definition
> > ldm.h:109: warning: `START_SECT' redefined
> > ldm.h:92: warning: this is the location of the previous definition
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > pipe -mpreferred-stack-boundary=2 -march=i686    -c -o msdos.o msdos.c
> > rm -f partitions.o
>
>Thanks - fixed

It's quite funny gcc-2.96 doesn't give these warnings. Perhaps it sees that 
the defines are identical and shuts up?

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

