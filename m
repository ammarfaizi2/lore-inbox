Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSGNTs5>; Sun, 14 Jul 2002 15:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSGNTs4>; Sun, 14 Jul 2002 15:48:56 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:2066 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317037AbSGNTsz>; Sun, 14 Jul 2002 15:48:55 -0400
Date: Sun, 14 Jul 2002 21:51:42 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714195142.GD13867@louise.pinerecords.com>
References: <200207141941.g6EJfAr4019406@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207141941.g6EJfAr4019406@burner.fokus.gmd.de>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 40 days, 10:24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> A Pentium 1200 running Linux-2.5.25 (ext3) results in:
> >> 
> >> # star -xp -time < rock.tar.bz2
> >> star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
> >> star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
> >> star: Total time 3190.483sec (32 kBytes/sec)
> >> 53:10.490r 12.299u 2970.099s 93% 0M 0+0k 0st 0+0io 4411pf+0w
> >> 
> >> You see, during the 53:20, the machine is only 7% idle!
> 
> 
> >A Pentium 1200, eh?
> >More like Pentium 120 or star just doesn't cut it.
> 
> star uses less CPU time than GNU tar. As GNU tar uses a proprietary 
> archive format, I never use it if I may avoid to use it.

How does this relate to the test? I got the archive directly off your
ftp site -> the software has been dealing with exactly the same format
in both cases.

> >Athlon 1GHz:
> 
> >kala@nibbler:/tmp/1$ time tar xjf rock.tar.bz2
> >real    3m19.703s
> >user    0m9.870s
> >sys     0m24.840s
> 
> >According to top, the system was ~90% idle during the extraction.
> >Linux 2.4.19-rc1-ac3, reiserfs 3.6.
> 
> Well, I wrote that this has been done with ext3 (I also checked ext2
> which is approx. the same speed.
> I don't have access to a reiserfs system that has not been compiled
> with debug and I don't like to put out false statements.

I honestly doubt ext3 would perform significantly worse than what I've
observed with reiserfs.

Never mind, however, the sole aim of my having tested the extraction of
rock.tar.bz2 was to show how easily you get to accuse people on lkml of
being incompetent w/o having any real support for your claims.

> >PS. Solaris is over 60% slower than Linux 2.2/2.4 in common fs
> >operations on my SMP SPARCstation 10.
> 
> If you make such statements, it would help a lot of you would mention
> the Solaris version you are running. I am always running a recent
> Solaris beta kernel - you may have used an outdated version.

Umm, let's see if I can fish out the install media from somewhere...
jup, Solaris 2.6 5/98.

T.
