Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132826AbRDDOHQ>; Wed, 4 Apr 2001 10:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132827AbRDDOHG>; Wed, 4 Apr 2001 10:07:06 -0400
Received: from xxlo.krakow.ids.pl ([212.160.185.145]:53516 "HELO
	xxliceum.krakow.ids.pl") by vger.kernel.org with SMTP
	id <S132826AbRDDOGw>; Wed, 4 Apr 2001 10:06:52 -0400
Date: Wed, 4 Apr 2001 16:03:54 +0200
From: Daniellek <daniel@rotfl.linux.krakow.pl>
To: linux-kernel@vger.kernel.org
Subject: possible problem with moxa intellio driver in 2.4.x kernels
Message-ID: <20010404160354.B22936@rotfl.linux.krakow.pl>
Mail-Followup-To: Daniellek <daniel@rotfl.linux.krakow.pl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: =?iso-8859-2?Q?Co_by_tu_wpisa=E6=3F_Mo=BFe_daniellek=2Ez=2Edomu_=3F_=3B?=
 =?iso-8859-2?Q?=29?=
X-Operating-System: Linux 2.2.17
X-Wyslij-mi-SMSa: daniel-sms@linux.krakow.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have MOXA C218Turbo PCI card, in the moment i have 4 leased lines connected
to it (all of them 115200). Form time to time (2 times a day, sometimes 1
time/2 days - seems random), one or more ports looks like there're dead...
Pppd is loaded, interface is up, but there's no activity on port (i look at
activity with "mxmon" supplied with moxa).

When interface is up and runnig i've got:
Baud Rate - 115200
CTS - ON
DSR - ON
DCD - ON
when it's up, but dead, i've got:
Baud Rate - 9600
CTS - OFF
DSR - OFF
DCD - ON

Currently i'm using 2.4.3 kernel, but have used 2.4.2-ac11 and -ac26
System is Slackware 7.2 (pre), glibc 2.2.1, pppd 2.4.1 (with 2.4.0 the problem
was the same)

What more informations should i supply to find cure? :)

PS. When port hangs, I can run moxaload one more time, restart pppd, and
connections are wroking for another day or X hours...

-- 
Daniel Fenert            --==> daniel@linux.krakow.pl <==--
==-P o w e r e d--b y--S l a c k w a r e-=-ICQ #37739641-==
Fear turned out to be a key to all doors --Alistair MacLean
===- http://daniellek.linux.krakow.pl/ -===< +48604628083 >
