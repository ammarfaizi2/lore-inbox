Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUERWkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUERWkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUERWkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:40:37 -0400
Received: from [80.28.60.165] ([80.28.60.165]:11212 "HELO medusa.homeunix.net")
	by vger.kernel.org with SMTP id S263725AbUERWkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:40:20 -0400
From: "Williams Parker" <listas@medusa.homeunix.net>
Date: Wed, 19 May 2004 00:31:33 +0200
To: linux-kernel@vger.kernel.org
Subject: driver ppp trouble
Message-ID: <20040518223133.GA31411@sakroot.org>
References: <200405161425.57745.rpaskowitz@confucius.ca> <1084736118.4172.6.camel@DustPuppy.LNX.RO> <200405170838.40560.hpoley@dds.nl> <20040518080507.GA15247@hmmn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518080507.GA15247@hmmn.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my machine:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 300.686
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov mmx
bogomips        : 599.65

pppd version:
ii  ppp             2.4.2+20031127- Point-to-Point Protocol (PPP) daemon
ii  pppoe           3.5-3           PPP over Ethernet driver


kernel:

Linux MeDuSa.homeunix.net 2.4.24 #1 Sat Jan 1 00:29:11 CET 2000 i686
GNU/Linux


 cat /etc/ppp/peers/dsl-provider
 pty "pppoe -I eth0 -T 80 -m 1452"


 grep -i ppp /boot/config-2.4.24
 CONFIG_PPP=y
 # CONFIG_PPP_MULTILINK is not set
 CONFIG_PPP_FILTER=y
 CONFIG_PPP_ASYNC=y
 # CONFIG_PPP_SYNC_TTY is not set
 CONFIG_PPP_DEFLATE=y
 CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPPOE is not set



Hello I have troubles with conection adsl in my host,
hang down every low time and i see error messages:

it is frecuently--->

May 13 04:16:11 MeDuSa pppd[302]: tcflush failed: Input/output error
May 13 05:54:13 MeDuSa pppoe[7149]: read (asyncReadFromPPP): Session
7355: Input/output
May 18 15:45:47 MeDuSa pppoe[21082]: Bad TCP checksum 4a5a
May 18 15:45:53 MeDuSa pppoe[21082]: Bad TCP checksum 4a5a
May 18 20:34:34 MeDuSa pppoe[21082]: Bad TCP checksum 4654




and my stadistics times conecction stablished in link pppoe:

May  4 03:06:41 MeDuSa pppd[769]: Connect time 3472.2 minutes.
May  4 03:06:41 MeDuSa pppd[769]: Connect time 3472.2 minutes.
May  5 05:19:14 MeDuSa pppd[3974]: Connect time 1560.4 minutes.
May  5 05:19:14 MeDuSa pppd[3974]: Connect time 1560.4 minutes.
May  6 02:17:47 MeDuSa pppd[30601]: Connect time 1248.3 minutes.
May  6 02:17:47 MeDuSa pppd[30601]: Connect time 1248.3 minutes.
May  7 08:47:55 MeDuSa pppd[21842]: Connect time 1818.4 minutes.
May  7 08:47:55 MeDuSa pppd[21842]: Connect time 1818.4 minutes.
May 10 12:30:53 MeDuSa pppd[20320]: Connect time 4533.4 minutes.
May 10 12:30:53 MeDuSa pppd[20320]: Connect time 4533.4 minutes.
May 13 04:16:11 MeDuSa pppd[302]: Connect time 828.4 minutes.
May 13 04:16:13 MeDuSa pppd[302]: Connect time 828.4 minutes.
May 13 05:54:13 MeDuSa pppd[7145]: Connect time 97.6 minutes.
May 13 05:54:13 MeDuSa pppd[7145]: Connect time 97.6 minutes.
May 14 22:06:32 MeDuSa pppd[7984]: Connect time 2392.5 minutes.
May 14 22:06:32 MeDuSa pppd[7984]: Connect time 2392.5 minutes.
May 15 02:17:37 MeDuSa pppd[19383]: Connect time 247.6 minutes.
May 15 02:17:37 MeDuSa pppd[19383]: Connect time 247.6 minutes.



thanks 
