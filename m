Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315509AbSEHDhz>; Tue, 7 May 2002 23:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315510AbSEHDhy>; Tue, 7 May 2002 23:37:54 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:27987 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315509AbSEHDhx>; Tue, 7 May 2002 23:37:53 -0400
Message-Id: <5.1.0.14.2.20020508043035.028a7110@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 08 May 2002 04:38:31 +0100
To: Dave Jones <davej@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.14 IDE 57
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020507185151.A12134@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:51 07/05/02, Dave Jones wrote:
>On Tue, May 07, 2002 at 03:29:28PM +0100, Anton Altaparmakov wrote:
>  > [aia21@drop hda]$ ideinfo
>  > bash: ideinfo: command not found
>  > Obviously distros haven't caught up with this development. )-:
>  > Care to give me a URL? A quick google for "ideinfo Linux download" didn't
>  > bring up anything looking relevant.
>
>Can't find where I got it from, and it seems to have fallen off google.
>I put up the last version I had (which I hacked up a bit) at
>http://www.codemonkey.org.uk/cruft/ide-info-0.0.5-dj.tar.gz

Ok, will get that. Someone else emailed me a url and I tried that earlier 
on (ages ago it seems) it said version 0.0.4 and it displayed a lot of crap 
on a 2.5.14 running kernel. Certainly it bears no resemblance to what 
/proc/ide/via has to say and it certainly bears no resemblance to 
reality... )-: i hope...

>  > >The parsing gunk we have for /proc/ide is fugly, and should have been
>  > >done with sysctls from day one imo.
>  >
>  > I like text parsing.
>
>must.. resist.. /proc ascii/bin... holywar..
>(besides, sysctl interface gives you ascii in /proc/sys/)

It does indeed (if implemented). Agreed if Martin were to change to sysctl 
with /proc interface great, it would just mean /proc/ide becomes 
/proc/sys/ide, nothing against that....

>  > It is not performance critical and makes info human
>  > readable... Whether existing text parsers are any good or not, I don't
>  > care, write a better one if you don't like the existing one
>
>That's likely exactly the reason we ended up with the dungheap we have
>now. Rewriting the parser when we already have a usable sysctl interface
>seems to have no gain over the existing mess to me.

Probably... I agree sysctl is great. I use it in ntfs myself. (-: And i 
think the /proc/sys is very nice... And for people who don't like it or who 
don;'t compile /proc fs they can use _sysctl...

Cheers,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

