Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTBHPCM>; Sat, 8 Feb 2003 10:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbTBHPCM>; Sat, 8 Feb 2003 10:02:12 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:5446 "EHLO
	exchange.Pronto.TV") by vger.kernel.org with ESMTP
	id <S267013AbTBHPCK> convert rfc822-to-8bit; Sat, 8 Feb 2003 10:02:10 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.59: loadavg shows 1.0 1.0 1.0 on idle system.(no APM enabled)
Date: Sat, 8 Feb 2003 16:11:49 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302081611.49069.roy@karlsbakk.net>
X-OriginalArrivalTime: 08 Feb 2003 15:12:31.0359 (UTC) FILETIME=[803820F0:01C2CF84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I've got this computer running 2.5.59, and after some time (dunno how long) it 
starts getting the load average stably at 1.0 while still being idle. check 
below for more info:

tonje:/usr/src/linux# uptime
 15:14:20 up 11 days,  4:08,  2 users,  load average: 1.00, 1.00, 1.00
tonje:/usr/src/linux# cat /proc/loadavg
1.00 1.00 1.00 1/95 12972

tonje:/usr/src/linux# vmstat 1 5
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0    176  40220 137828 197012    0    0     2     9   23    30  1  0 99  0
 0  0    176  40220 137828 197012    0    0     0     0 1005   191  0  0 100  
0
 0  0    176  40220 137828 197012    0    0     0     0 1003   189  0  0 100  
0
 0  0    176  40220 137828 197012    0    0     0     0 1004   190  0  0 100  
0
 0  0    176  40220 137828 197012    0    0     0    72 1013   204  0  1 99  0

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

