Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSJIXBZ>; Wed, 9 Oct 2002 19:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSJIXBZ>; Wed, 9 Oct 2002 19:01:25 -0400
Received: from smtp3.vol.cz ([195.250.128.83]:14098 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S262667AbSJIXA5>;
	Wed, 9 Oct 2002 19:00:57 -0400
Date: Wed, 9 Oct 2002 21:06:11 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: linux-kernel@vger.kernel.org
Subject: GL620USB-A - searching for owner of this hardware (USB-to-USB cable)
Message-ID: <20021009190611.GA541@utx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,

I am searching for any owner of USB cable or mainboard containing chip
GL620USB-A, which is _not connected_ to VIA USB hub on any side.

I have a request for a small test, which will help me to trace down
problem - whether found bug is problem of VIA USB driver or GL620USB-A
driver.

There is a test:

1) Verify, whether your USB hub (mainboard) is not VIA. If it is VIA (on
one or both sides), you cannot do this test.

If it is not VIA, you can continue:

2) Please do a few ping and flood ping tests (must be root) and let me
know results (percent of lost packets):

Normal ping tests:
ping -s 2952 second_machine
ping -s 2953 second_machine
(Needed to collect only few packets.)

Ad flood ping tests:
ping -c 1000 -f second_machine
ping -c 1000 -s 2952 -f second_machine
ping -c 1000 -s 2953 -f second_machine

If there is a packet loss, please try both USB hub drivers (UHCI and
alternate UHCI).

Thanks to all for support
-- 
Stanislav Brabec
http://www.penguin.cz/~utx
