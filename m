Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSGYNlx>; Thu, 25 Jul 2002 09:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGYNk5>; Thu, 25 Jul 2002 09:40:57 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:13738 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314080AbSGYNia>; Thu, 25 Jul 2002 09:38:30 -0400
Message-Id: <5.1.0.14.2.20020725144011.00ab3ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Jul 2002 14:45:13 +0100
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: RE: 2.5.28 and partitions
Cc: Linus Torvalds <torvalds@transmeta.com>, Matt_Domsch@Dell.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <1D94527606@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:24 25/07/02, Petr Vandrovec wrote:
>On 25 Jul 02 at 14:03, Anton Altaparmakov wrote:
> > At 12:44 25/07/02, Alexander Viro wrote:
> > >Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> > >device should seek professional help of the kind they don't give on l-k...
> >
> > Why? What is wrong with large devices/file systems? Why do we have to 
> break
> > up everything into multiple devices? Just because the kernel is "too lazy"
> > to implement support for large devices? Nobody cares if 64bit code is
> > 10-20% slower than 32bit code on a storage server. The storage devices are
>
>But I care whether gcc barfs on code or not, and whether generated code
>is correct or not.

Everyone cares about that! That has nothing to do with performance. It's 
simply a broken compiler which needs fixing.

>I do very trivial 64bit computations in TV-Out portion of matroxfb,
>but I spent two days shifting code up/down, adding temporary variables
>and splitting expressions to simple ones to make code compilable at all
>with gcc-2.95.4 compiling module for PIII kernel (Debian bug #151196).
>So I personally cannot recommend doing any 64bit math without setting
>gcc-3.0 as minimal version for ia32 architecture.

Thanks for the warning. I will keep an eye out for eventual "NTFS is broken 
with gcc-2.95 reports"... Although I would make that gcc-2.96 and not 3.0 
as minimum requirement. At least I haven't found anything wrong with the 
current gcc-2.96...

(Please let's not start another flamewar about whether gcc-2.96 exists or not.)

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

