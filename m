Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbSLIQnj>; Mon, 9 Dec 2002 11:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbSLIQnj>; Mon, 9 Dec 2002 11:43:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62119 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S265786AbSLIQnh>;
	Mon, 9 Dec 2002 11:43:37 -0500
Date: Mon, 9 Dec 2002 17:54:07 +0100
From: ksardem@linux01.gwdg.de
X-Mailer: The Bat! (v1.60q) Personal
Reply-To: ksardem@linux01.gwdg.de
Organization: KKI
X-Priority: 3 (Normal)
Message-ID: <1653237694.20021209175407@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
CC: manfred@colorfullife.com
Subject: Re: bug in via-rhine network-driver (transmit timed out)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I successfully got the old transmit-out-error again ;-)
- and this time with "options via-rhine debug=3" in modules.conf.
So here are the debug-messages:

dmesg:

eth0: Shutting down ethercard, status was 081a.
eth0: via_rhine_open() irq 9.
eth0: reset finished after 5 microseconds.
eth0: Done via_rhine_open(), status 081a MII status: 7809.
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
eth0: reset did not complete in 10 ms.
eth0: reset finished after 10005 microseconds.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
eth0: reset did not complete in 10 ms.
eth0: reset finished after 10005 microseconds.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
eth0: reset did not complete in 10 ms.
eth0: reset finished after 10005 microseconds.
eth0: Shutting down ethercard, status was 883a.
eth0: via_rhine_open() irq 9.
eth0: reset did not complete in 10 ms.
eth0: reset finished after 10005 microseconds.
eth0: Done via_rhine_open(), status 881a MII status: 782d.
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
eth0: reset did not complete in 10 ms.
eth0: reset finished after 10005 microseconds.
eth0: Shutting down ethercard, status was 883a.
eth0: via_rhine_open() irq 9.
eth0: reset did not complete in 10 ms.
eth0: reset finished after 10005 microseconds.
eth0: Done via_rhine_open(), status 881a MII status: 7829.
eth0: Shutting down ethercard, status was 883a.  

lsmod was:

via-rhine 13612 2
mii        1232 0 [via-rhine]

-- 
Bye.
Kristof <ksardem@linux01.gwdg.de>

