Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315822AbSEGO3Y>; Tue, 7 May 2002 10:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315831AbSEGO3X>; Tue, 7 May 2002 10:29:23 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:52272 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315822AbSEGO3R>; Tue, 7 May 2002 10:29:17 -0400
Message-Id: <5.1.0.14.2.20020507151627.02390bd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 May 2002 15:29:28 +0100
To: Dave Jones <davej@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.14 IDE 57
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020507160825.S22215@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:08 07/05/02, Dave Jones wrote:
>On Tue, May 07, 2002 at 02:57:46PM +0100, Anton Altaparmakov wrote:
>  > How do I get this information with hdparm please?
>  >
>  > [aia21@drop ide]$ cat via
>
>Bartlomiej Zolnierkiewicz moved all this stuff to userspace
>a long time ago in 'ideinfo'.

[aia21@drop hda]$ ideinfo
bash: ideinfo: command not found

Obviously distros haven't caught up with this development. )-:

Care to give me a URL? A quick google for "ideinfo Linux download" didn't 
bring up anything looking relevant.

>  > [aia21@drop hda]$ cat cache
>  > 1916
>  > [aia21@drop hda]$ cat capacity
>  > 80418240
>  > [aia21@drop hda]$ cat geometry
>  > physical     79780/16/63
>  > logical      5005/255/63
>  >
>  > And hdparm never gives you the physical geometry AFAICS.
>
>Why would a normal user ever need to know this info?

I want to know this info. (-: Admittedly normal users don't need it... It 
is useful for diagnosing problems with NTFS and MD setups for example (in 
conjunction with fdisk -l shown in sectors).

>  > And as I said, I can understand removing the ability to write values into
>  > /proc/ide/*, what I disagree with is the removal of the information
>  > provided by read-only access to /proc/ide/*. And that is because I am not
>  > aware of any other way to get the same information.
>
>The parsing gunk we have for /proc/ide is fugly, and should have been
>done with sysctls from day one imo.

I like text parsing... It is not performance critical and makes info human 
readable... Whether existing text parsers are any good or not, I don't 
care, write a better one if you don't like the existing one or go beat up 
the people who wrote the bad ones... That seems to be Martin's standard 
reply, so I thought I would use it, too. (-;

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

