Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUDNUdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUDNUdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:33:12 -0400
Received: from smtpout1.compass.net.nz ([203.97.97.135]:53202 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S261615AbUDNUdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:33:04 -0400
Date: Thu, 15 Apr 2004 08:31:00 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.5-mjb1 Comment.
Message-ID: <Pine.LNX.4.53.0404150815250.654@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Test 2.6.5-mjb2 for more than 2 days only, system is pretty stable (the same as
almost all other 2.6.x with my box). The significant performance improved
compared to 2.6.5-aa5, 2.6.5 and all others 2.6.x for with a low end box line mine
(660 Mhx Celeron 256 Mb RAM) make me write this comment. :-) Wish that some
improvement could make way to the mainline kernel.

The memory management is nearly perfect. Before I tried one ck kernel use auto
regulation swap and it was still much worse than this one as I noticed the value
in swappiness also changes by the time.

Here is one of the usage senario with my box: Running
1. Netbean-3.6-rc1
2. Tomcat 5.0.19
3. A dictionary server written in Java (my work)
4. Mozilla to test local Tomcat
5. 3 terminals, one centericq, one pine
6. Icewm

6. bash-2.05b$ free
		total       used       free     shared    buffers      cached
   Mem:        255240     252376       2864          0       7924      89532
  -/+ buffers/cache:     154920     100320
  Swap:       256960       3996     252964

Compared to all other 2.6.x and 2.4.x the swap usages for the same is about 30Mb
and if I do lots of compiling jsp pages, it increased to nearly 128Mb swap and
system became rather slugish. With 2.6.5-mjb2 the maximum swap usage I noticed is
30Mb and system response is quite good.

Thank you for doing a good job so I can still keep my old box for working :-)

Steve Kieu
