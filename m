Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSLNSU3>; Sat, 14 Dec 2002 13:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSLNSU3>; Sat, 14 Dec 2002 13:20:29 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:32641 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265578AbSLNSU2> convert rfc822-to-8bit;
	Sat, 14 Dec 2002 13:20:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 load avg += 1 (more info)
Date: Sat, 14 Dec 2002 19:28:17 +0100
User-Agent: KMail/1.4.1
References: <200212141817.21202.roy@karlsbakk.net>
In-Reply-To: <200212141817.21202.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212141928.17222.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

just more info...

tonje:~# vmstat 3
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
0  0      0  40388 193024 180772    0    0     1     5   86     8  0  0 99  0
0  0      0  40388 193024 180772    0    0     0     0 1002     7  0  0 100  0
0  0      0  40388 193024 180772    0    0     0    24 1005    16  0  0 100  0
0  0      0  40388 193024 180772    0    0     0     0 1001     6  0  0 100  0
0  0      0  40388 193024 180772    0    0     0     0 1001     8  0  0 100  0
0  0      0  40252 193024 180772    0    0     0    15 1007    15  0  0 100  0
tonje:~# cat /proc/uptime && sleep 10 &&  cat /proc/uptime
374786.48 372940.50
374796.48 372950.50
tonje:~#

...rebooting machine...

roy@tonje:~$ uptime
 18:25:23 up 4 min,  1 user,  load average: 0.00, 0.02, 0.00

huh?

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

