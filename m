Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271549AbRHPKxQ>; Thu, 16 Aug 2001 06:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271552AbRHPKxG>; Thu, 16 Aug 2001 06:53:06 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:36112 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S271549AbRHPKw4>;
	Thu, 16 Aug 2001 06:52:56 -0400
Date: Thu, 16 Aug 2001 13:53:07 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.8 vs 2.4.7 observations on loaded web server
Message-ID: <Pine.LNX.4.33.0108161349370.3011-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
I have a machine that's loaded web server (600-800 req/sec), that
pushes 35-55 mbits/s traffic. It runs good on 2.4.7 , with
loadavg between 3 and 5, and because of the different opinions
about 2.4.8 VM and stuff, tried that too. The result was not good.
Observing /proc/meminfo, the active memory was a lot more -
about 500MM ( under 2.4.7 it's about 240MB), it ate all the swap
(the machine has 1G ram and 200 MB swap), and was working somewhat
worse.
Hope this observation helps, if anyone has any questions, feel free
to mail me :)

