Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbRESEKb>; Sat, 19 May 2001 00:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRESEKV>; Sat, 19 May 2001 00:10:21 -0400
Received: from [195.250.204.70] ([195.250.204.70]:27260 "EHLO raq.trendnet.si")
	by vger.kernel.org with ESMTP id <S261640AbRESEKF>;
	Sat, 19 May 2001 00:10:05 -0400
From: Dworf <dworf@trendnet.si>
Reply-To: dworf@trendnet.si
To: linux-kernel@vger.kernel.org
Subject: Problem! kernel: TCP: too many of orphaned sockets
Date: Sat, 19 May 2001 06:13:46 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01051906134600.05643@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

I have a little problem, I have an Pentium 266Mhz linux box with kernel 2.4.2 
with 64mb of memory, After about an 1 day of running i get this msg loged in

/var/log/messages

kernel: TCP: too many of orphaned sockets

after that noone can telnet to the box or anything couse of the sockets 
beeing all used. I have to reboot then its ok again for about a day, and Im 
not running many processes

if i do netstat i get about 100 connections...

why are all the sockets used?

If i do the

cat /proc/net/socketstat
sockets: used 405
TCP: inuse 102 orphan 0 tw 0 alloc 156 mem 2
UDP: inuse 12
RAW: inuse 0
FRAG: inuse 0 memory 0


So if i look at socketstats more often the "sockets: used XXX" the XXX number 
is going only up! and never down.

What should i do to fix this?
Where is the problem?

Thank you all for your help!
