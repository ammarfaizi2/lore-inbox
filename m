Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287602AbRLaSyH>; Mon, 31 Dec 2001 13:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287597AbRLaSx6>; Mon, 31 Dec 2001 13:53:58 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:27791 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S287599AbRLaSxq>; Mon, 31 Dec 2001 13:53:46 -0500
From: "Karol Pietrzak" <noodlez84@earthlink.net>
To: linux-kernel@vger.kernel.org
Date: Mon, 31 Dec 2001 13:42:22 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: slow CD ripping from moving from 2.4.4 to 2.4.17
Reply-to: noodlez84@earthlink.net
Message-ID: <3C306B3E.24055.F50EE@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
Using 2.4.4 up to, I believe, 2.4.14, CD ripping was fine.  My 
Plextor 12/10/32S (S for SCSI) ripped audio CDs at around 25X, 
even sometimes at 30X.  While ripping, my hard drive would work 
continuously, and so would my CDRW drive.

Now with 2.4.17, my hard drive can't keep up with my CDRW drive: 
everything happens in bursts.  My CDRW drive starts ripping as 
fast as possible, but my hard drive doesn't do anything (0-5 
seconds).  Then, my hard drive decides to start writing, which 
stops the CD ripping process (5-8 seconds).  Now that the hard 
drive is done, the CDRW drive continues ripping... for 4 seconds 
and the process continues over and over again.  This brings down 
the ripping speed down to ~18X, a far cry from the 30X achieved 
with 2.4.4 and very close to the writing speed of my CDRW drive 
(12X), which is ridiculous.

As stated before, ripping is fine in 2.4.4 (which I still keep 
around because of this problem).  What does help in 2.4.17, 
however, is manually entering running the 'sync' command ever 
second or so on another console.  This makes the ripping process 
a lot more "continuous," like 2.4.4.

I can't burn CDs in 2.4.4, however, because that freezes up my 
computer, for some reason.  That happens a lot less often in 
2.4.17 (but that's another matter).

I am using SuSE 7.2 Pro with the latest cdda2wav (1.11a12).

Linux linux 2.4.17 #2 Fri Dec 21 17:14:19 EST 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0k-pre15
PPP                    2.4.0
Linux C Library        x    1 root     root      1343073 May 11  
2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         ppp_async ppp_generic slhc nls_cp437 vfat 
fat

I am using a Pentium I 233 with 32MB of RAM.  I have an Advansys 
Ultra SCSI card with 3 devices total hooked up to it.

Anyone have any ideas?  Anything I can do?

Thank you ahead of time to anyone willing to help.

--
Karol Pietrzak
PGP KeyID: 3A1446A0
