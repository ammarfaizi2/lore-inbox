Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRGVPV7>; Sun, 22 Jul 2001 11:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbRGVPVu>; Sun, 22 Jul 2001 11:21:50 -0400
Received: from woody.ichilton.co.uk ([216.29.174.40]:6921 "EHLO
	woody.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S266559AbRGVPVq>; Sun, 22 Jul 2001 11:21:46 -0400
Date: Sun, 22 Jul 2001 16:21:50 +0100
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: linux-kernel@vger.kernel.org
Subject: OT: Journaling FS Comparison
Message-ID: <20010722162150.A23381@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

If this question is already covered somewhere by a web page or article,
then please drop me the URL, but I have not seen such a thing, so was wondering
if someof the developers of the journaling filesystems could comment on the
progress of the systems.

I'd also be interested in knowing what journaling fs the developers around here
use in general...

With there been 4 of them (ext3, reiserfs, XFS and JFS),
it's not an easy choice for anyone.

ext3 stands out because of it's compatibility with ext2 - this makes
it easy to 'upgrade' from ext2 to ext3 without loosing/moving data.
Also it would be much easier to move a drive into another machine
without worrying about the kernel having reiserfs etc compiled in.

However, I have heard ext3 is slower (obviously because it has extra
writes) and sometimes has instibilities.

I also heard that ReiserFS is the fastest out of the bunch, but all
data is lost on converstion, and obviously rescuing and moving disks is
harder. But, it is in the main kernel tree..

Anyway, maybe someone could comment on the different options across the
filesystems, like speed, stable?, nfs?, raid?, convert from ext2?


Also, while I am posting off topic, as part of going to a journaling
fs, I was considering moving my nfs/netboot server from 2.2.19 to 2.4.x
- how's the nfs code working on 2.4, compared to 2.2, especially speed
wise?


Thanks in Advance!


Bye for Now,

Ian


                                  \|||/ 
                                  (o o)
 /-----------------------------ooO-(_)-Ooo----------------------------\
 |  Ian Chilton                    E-Mail: ian@ichilton.co.uk         |
 |  IRC Nick: GadgetMan            Backup: ichilton@www.linux.org.uk  |
 |  ICQ: 16007717 / 104665842      Web   : http://www.ichilton.co.uk  |
 |--------------------------------------------------------------------|
 |       For people who like peace and quiet: a phoneless cord        |
 \--------------------------------------------------------------------/

