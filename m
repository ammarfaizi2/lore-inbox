Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSERSmW>; Sat, 18 May 2002 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSERSmV>; Sat, 18 May 2002 14:42:21 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:58391 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313767AbSERSmU>; Sat, 18 May 2002 14:42:20 -0400
Message-Id: <5.1.0.14.2.20020518194031.04025d10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 18 May 2002 19:42:29 +0100
To: Adrian Bunk <bunk@fs.tum.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: linux 2.5.16 and VIA Chipset
Cc: mikeH <mikeH@notnowlewis.co.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0205181706400.21287-100000@mimas.fachschafte
 n.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:10 18/05/02, Adrian Bunk wrote:
>On Sat, 18 May 2002, Anton Altaparmakov wrote:
> > At 13:47 18/05/02, mikeH wrote:
> > >Apologies, on closer examination of the 2.4 and 2.5 dmesg, it hangs just
> > >before the
> > >ACPI is going to come up. However, there is no option for it in make
> > >menuconfig, and enabling it in .config breaks the compile.
> >
> > What do you mean there is no config option in menuconfig?!? I just checked
> > and there is "General options" ---> "ACPI Support" ---> "[ ] ACPI Support".
>
>There are two options that are required and it might be that one of them
>is missing:
>
>1. "Code maturity level options" -> "Prompt for development and/or
>                                      incomplete code/drivers"

Not true in 2.5.x. ACPI is not dependent on config experimental. Just checked.

>2. "General setup" -> "Power Management support"

Not true in 2.5.x. Power management is not a prerequisite for ACPI in 
2.5.x. You notice this already by the fact that ACPI is not under the power 
management menu any more...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

