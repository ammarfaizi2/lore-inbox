Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbRBZGRJ>; Mon, 26 Feb 2001 01:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130171AbRBZGRA>; Mon, 26 Feb 2001 01:17:00 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:13005 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130167AbRBZGQt>; Mon, 26 Feb 2001 01:16:49 -0500
Date: Sun, 25 Feb 2001 22:16:43 -0800
From: Justin Huff <jjhuff@cs.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac4: eth0: interrupt(s) dropped!
Message-ID: <20010225221643.Y22028@etna.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this in my syslog:

Feb 25 21:51:35 chimborazo kernel: eth0: interrupt(s) dropped!
Feb 25 21:52:04 chimborazo last message repeated 2 times
Feb 25 21:56:35 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 25 21:56:37 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 25 21:56:39 chimborazo kernel: eth0: interrupt(s) dropped!
Feb 25 21:56:48 chimborazo last message repeated 4 times
Feb 25 21:56:50 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 25 21:56:58 chimborazo last message repeated 4 times
Feb 25 22:01:08 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 25 22:01:18 chimborazo kernel: eth0: interrupt(s) dropped!
Feb 25 22:01:24 chimborazo kernel: eth0: interrupt(s) dropped!

I have CONFIG_APL_ALLOW_INTS set.  The NIC is a ne2k based pcmcia card. 
I'm running 2.4.2-ac4, but this has been happening since 2.4.1.
Ideas?

--Justin

