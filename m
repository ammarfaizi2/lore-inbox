Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTECTOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTECTOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:14:50 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:25614 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id S263394AbTECTOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:14:48 -0400
Message-ID: <1571.194.100.165.159.1051990031.squirrel@webmail.mbnet.fi>
Date: Sat, 3 May 2003 22:27:11 +0300 (EEST)
Subject: Re: 2.5.68-mm4 and 3c900 is a horror
From: Kmt Sundqvist <rabbit80@mbnet.fi>
To: <akpm@digeo.com>
In-Reply-To: <20030502150402.26c4f3b3.akpm@digeo.com>
References: <20030502150402.26c4f3b3.akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 03 May 2003 19:27:15.0454 (UTC) FILETIME=[00F2F1E0:01C311AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kimmo Sundqvist <rabbit80@mbnet.fi> wrote:

>> May  2 20:34:10 minjami kernel: irq 19: nobody cared!

> Very odd.  How often does this happen?

Actually I was booting up for the first time with -mm4 as it happened. 
The first 8 errors I copied verbatim, and the 22 that happened after the
8th but before the machine locked up I left out.  So my guess is that
whatever happened there, happened every time.
The system is set so that it runs kdm on boot, and opens a PPPoE link from
/etc/ppp/ppp_on_boot with
pppd pty "pppoe -I eth0 -m 1412" debug defaultroute

The screen went black, which is normal in itself, but the X background
didn't appear.  Neither did it switch virtual consoles, or beep or
anything while I tried. Just can't remember was my display in sync or not,
but either way, pressing any (many) keys didn't put it in sync or out.
The kernel I was running in my previous boot was 2.5.68-osdl2, and
2.5.68-mm4 was also compiled while 2.5.68-osdl2 was running.  All
userspace stuff is neatly set up, and with ordinary 2.5.68 (and
2.5.68-osdl2) everything works fine, with the exception of ALSA.  OSS
works.
The ReiserFS partitions didn't complain on next bootup.

-Kimmo Sundqvist


