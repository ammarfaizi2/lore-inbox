Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268877AbRG0QG2>; Fri, 27 Jul 2001 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268876AbRG0QGS>; Fri, 27 Jul 2001 12:06:18 -0400
Received: from tangens.hometree.net ([212.34.181.34]:13217 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S268870AbRG0QF6>; Fri, 27 Jul 2001 12:05:58 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Fri, 27 Jul 2001 16:06:04 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9js3hc$23l$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int> <3B6180CD.9D68CC07@namesys.com> <20010728030255.A804@weta.f00f.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 996249964 26085 212.34.181.4 (27 Jul 2001 16:06:04 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 27 Jul 2001 16:06:04 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Wedgwood <cw@f00f.org> writes:

>FWIW, Debian although it doesn't support reiserfs "out of the box" at
>present, works flawlessly for a large number of people I know.  I also
>hear Mandrake 7.2 and 8.0 work pretty nice if you want a pointy-clicky
>experience :)

>Since so many people seem to run RedHat, perhaps it's worth someone
>determining exactly what is busted with their init scripts or whatever
>that makes reiserfs barf more often that with other distributions.

There is nothing wrong with RedHat init scripts.

I run RH 6.2 on my self-rolled 2.2.x kernels and they boot ReiserFS
fine and neither faster nor slower than ext2. Nothing wrong with
RedHat here.

I consider a vendor that does not always ship "latest and greatest"
but tries to stress test its software superior to one that crams out
one new release every three months. And if they enable paranoia mode
in the experimental sections of the kernel: Fine! Goes well with my
philosophy of server running. Leads to 500+ days uptime.

I dropped out of ReiserFS again, however, because of unexplained
problems with various user space applications (PostgreSQL 6.5.3 and
7.x or Highwind oops bCandid oops Software.Com oops Highwind-again
Cyclone and Typhoon) that are heavy thread and mmap() users. 

I use ReiserFS for my ftp-data-caroussels and as spool and staging
disks. Not for system disks that contain binaries or performance
critical application disks. That works fine. 


	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
