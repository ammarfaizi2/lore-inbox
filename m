Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTIATck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTIATcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:32:39 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:32520 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263230AbTIATci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:32:38 -0400
Date: Mon, 1 Sep 2003 21:32:35 +0200
To: linux-kernel@vger.kernel.org, davem@redhat.com, pp@ee.oulu.fi
Subject: 2.4, b44 transmit timeout
Message-ID: <20030901193235.GA8280@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have the following problem since I switched from bcm4400 to the
`in-kernel' driver b44:
Sep  1 17:37:11 gandalf vmunix: b44: eth0: Link is up at 10 Mbps, half duplex.
Sep  1 17:37:11 gandalf vmunix: b44: eth0: Flow control is off for TX and off for RX.
Sep  1 17:37:16 gandalf vmunix: NETDEV WATCHDOG: eth0: transmit timed out
Sep  1 17:37:16 gandalf vmunix: b44: eth0: transmit timed out, resetting
Sep  1 17:37:17 gandalf vmunix: b44: eth0: Link is down.
Sep  1 17:37:20 gandalf vmunix: b44: eth0: Link is up at 10 Mbps, half duplex.
Sep  1 17:37:20 gandalf vmunix: b44: eth0: Flow control is off for TX and off for RX.

and so on. This didn't (and still does not) happen with the bcm4400
(from debian sid bcm4400-source).

I compiled the kernel myself on debian/sid, it is a laptop (acer tm654).

If you need more information I will provide all I can do.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
TIMBLE (vb.)
(Of small nasty children.) To fail over very gently, look around to
see who's about, and then yell blue murder.
			--- Douglas Adams, The Meaning of Liff
