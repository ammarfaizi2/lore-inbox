Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270331AbRHMRsQ>; Mon, 13 Aug 2001 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270333AbRHMRsG>; Mon, 13 Aug 2001 13:48:06 -0400
Received: from press-gopher.uchicago.edu ([128.135.204.194]:4018 "EHLO
	press-gopher.uchicago.edu") by vger.kernel.org with ESMTP
	id <S270331AbRHMRsA>; Mon, 13 Aug 2001 13:48:00 -0400
Date: Mon, 13 Aug 2001 12:47:53 -0500 (CDT)
From: "Roy C. Bixler" <rcb@press-gopher.uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: VM lockup with 2.4.8 / 2.4.8pre8
Message-ID: <Pine.GSO.4.10.10108131229270.27903-100000@press-gopher.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just inadvertantly encountered a VM lockup with Linux 2.4.8.  The
KDE kspread application couldn't handle one spreadsheet I gave it and it
ran away consuming all memory in the system.  When I first ran into the
trouble, my machine has 384 Meg. RAM and 184 Meg. of swap.  I tried
2.4.8pre8 and the lockup still occurs.  I have increased my swap to 768
Meg. and 2.4.8 still locks up.  I tried 2.4.7 and it doesn't lockup - it
correctly OOM kills the runaway process.

The system feels responcive up until it locks up.  Running 'top' while it
happens show that the lockup occurs at about the point where swap runs
out.  Other system details: it is running the latest Debian snapshot.

Linux frobozz 2.4.8 #1 Sat Aug 11 19:26:35 CDT 2001 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.25
util-linux             2.11h
mount                  2.11h
modutils               2.4.6
e2fsprogs              1.22
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         cs4232 ad1848 uart401 sound soundcore parport_pc lp
parport ipx usb-uhci usbcore

-- 
Roy Bixler
The University of Chicago Press
rcb@press-gopher.uchicago.edu


