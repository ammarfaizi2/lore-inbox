Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280615AbRKJLPO>; Sat, 10 Nov 2001 06:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280617AbRKJLPE>; Sat, 10 Nov 2001 06:15:04 -0500
Received: from web10403.mail.yahoo.com ([216.136.130.95]:26639 "HELO
	web10403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280615AbRKJLOu>; Sat, 10 Nov 2001 06:14:50 -0500
Message-ID: <20011110111449.65726.qmail@web10403.mail.yahoo.com>
Date: Sat, 10 Nov 2001 22:14:49 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Problem. 2.4.13-ac7 ; FIFO write timed out
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have read a long thread about the similar problem
report for 2.4.0-pre kernel, but I am not sure if the
problem has been fixed. I still got that.

Description: If I set my LPT1 in Bios mode EPP+ECP dma
3; printing to HP laser Jet 6L I got the following
error message in syslog

FIFO write timed out
Nov 10 22:36:32 kieu kernel: parport0: FIFO is stuck
Nov 10 22:36:32 kieu kernel: parport0: BUSY timeout
(1) in compat_write_block_pio
Nov 10 22:36:32 kieu kernel: lp0 off-line

If I press the online button on the printer, it prints
but data loss (only half of the image printed) then it
stops printing again until I push online button one
more time so on...;

All problem is gone if I reset LPT1 in bios in PCSPP
mode. 

I am using debian testing with apsfilter (using cat to
send data to lpt1)

Pls help

PS: pls cc me as I am not subscribed to the list!



=====
S.KIEU

http://briefcase.yahoo.com.au - Yahoo! Briefcase
- Manage your files online.
