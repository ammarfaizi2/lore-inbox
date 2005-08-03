Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVHCPYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVHCPYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 11:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVHCPYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 11:24:34 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:29636 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262320AbVHCPY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 11:24:29 -0400
Date: Wed, 3 Aug 2005 17:24:26 +0200
To: linux-kernel@vger.kernel.org, pp@ee.oulu.fi
Subject: b44 transmit timeout with kernel 2.6
Message-ID: <20050803152426.GR30602@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Pekka, dear developers!

Some time ago I reported problems with transmit timeouts with b44 and
kernel 2.4 (http://lkml.org/lkml/2003/9/1/197 and followin discussion).

Now I have very similar problems with kernel 2.6:
Aug  2 09:53:15 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
Aug  2 09:53:15 gandalf vmunix: b44: eth0: Flow control is off for TX and off for RX.
Aug  2 09:53:15 gandalf ifplugd(eth0)[3291]: Link beat detected.
Aug  2 09:53:20 gandalf dnsmasq[3005]: reading /var/run/dnsmasq/resolv.conf
Aug  2 09:53:20 gandalf dnsmasq[3005]: using nameserver 193.205.4.2#53
Aug  2 09:53:20 gandalf dnsmasq[3005]: using nameserver 193.205.4.11#53
Aug  2 09:53:25 gandalf vmunix: NETDEV WATCHDOG: eth0: transmit timed out
Aug  2 09:53:25 gandalf vmunix: b44: eth0: transmit timed out, resetting
Aug  2 09:53:26 gandalf kernel: b44: eth0: Link is down.
Aug  2 09:53:26 gandalf ifplugd(eth0)[3291]: Link beat lost.
Aug  2 09:53:28 gandalf vmunix: b44: eth0: Link is up at 100 Mbps, full duplex.
Aug  2 09:53:28 gandalf vmunix: b44: eth0: Flow control is off for TX and off for RX.

and wanted to ask what I can do to overcome this problems again.

Currently I am running 2.6.13-rc4-mm1 on an acer travelmate 654LCi.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
`I am so amazingly cool you could keep a side of meat in
me for a month. I am so hip I have difficulty seeing over
my pelvis.'
                 --- Zaphod being cool.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
