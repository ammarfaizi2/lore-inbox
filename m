Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSGNTj5>; Sun, 14 Jul 2002 15:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSGNTj4>; Sun, 14 Jul 2002 15:39:56 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:14828 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317023AbSGNTjz>; Sun, 14 Jul 2002 15:39:55 -0400
Date: Sun, 14 Jul 2002 21:41:10 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141941.g6EJfAr4019406@burner.fokus.gmd.de>
To: schilling@fokus.gmd.de, szepe@pinerecords.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Tomas Szepe <szepe@pinerecords.com>

>> A Pentium 1200 running Linux-2.5.25 (ext3) results in:
>> 
>> # star -xp -time < rock.tar.bz2
>> star: WARNING: Archive is bzip2 compressed, trying to use the -bz option.
>> star: 10372 blocks + 1536 bytes (total of 106210816 bytes = 103721.50k).
>> star: Total time 3190.483sec (32 kBytes/sec)
>> 53:10.490r 12.299u 2970.099s 93% 0M 0+0k 0st 0+0io 4411pf+0w
>> 
>> You see, during the 53:20, the machine is only 7% idle!


>A Pentium 1200, eh?
>More like Pentium 120 or star just doesn't cut it.

star uses less CPU time than GNU tar. As GNU tar uses a proprietary 
archive format, I never use it if I may avoid to use it.

>--

>Athlon 1GHz:

>kala@nibbler:/tmp/1$ time tar xjf rock.tar.bz2
>real    3m19.703s
>user    0m9.870s
>sys     0m24.840s

>According to top, the system was ~90% idle during the extraction.
>Linux 2.4.19-rc1-ac3, reiserfs 3.6.

Well, I wrote that this has been done with ext3 (I also checked ext2
which is approx. the same speed.
I don't have access to a reiserfs system that has not been compiled
with debug and I don't like to put out false statements.

>PS. Solaris is over 60% slower than Linux 2.2/2.4 in common fs
>operations on my SMP SPARCstation 10.

If you make such statements, it would help a lot of you would mention
the Solaris version you are running. I am always running a recent
Solaris beta kernel - you may have used an outdated version.

The filesystem speed on Solaris did dramatically improve to the beginning
of the year 2001. This equates Solaris 8 01/01.


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
