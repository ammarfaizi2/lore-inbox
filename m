Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUBNLNv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 06:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUBNLNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 06:13:51 -0500
Received: from atari.saturn5.com ([209.237.231.200]:43661 "HELO
	atari.saturn5.com") by vger.kernel.org with SMTP id S261774AbUBNLNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 06:13:50 -0500
Date: Sat, 14 Feb 2004 03:13:49 -0800
From: Steve Simitzis <steve@saturn5.com>
To: linux-kernel@vger.kernel.org
Subject: e1000 problems in 2.6.x
Message-ID: <20040214111349.GC1040@saturn5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-gestalt: heart, barbed wire
X-Cat: calico
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello. since upgrading to 2.6 from 2.4.22, my e1000 devices have
been angry. i've tried running both 2.6.2 and 2.6.3-rc2, but the
results have been the same. when i return to 2.4.22, all of the
problems go away.

i'm getting these over and over again:

Feb 11 19:57:55 sg1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Feb 11 19:57:57 sg1 kernel: e1000: eth1 NIC Link is Up 100 Mbps Full Duplex
Feb 11 19:58:17 sg1 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Feb 11 19:58:18 sg1 kernel: e1000: eth1 NIC Link is Up 100 Mbps Full Duplex

i'm also seeing about 10-20% of my RX packets as errors when running 2.6.x,
and 0 errors when running 2.4.22.

another oddity is that even after forcing my interfaces to 100 Mbps
full duplex, my switch is reporting half duplex. again, this only happens
in 2.6.x. when running 2.4.22, full duplex is properly negotiated between
the e1000 and my switch.

i tried turning off TSO, as suggested elsewhere by Scott Feldman, but that
had no effect.

i would love to run 2.6, so if there's anything else i can try (or if
this is a known problem and about to be fixed), please let me know.

thanks in advance.

:)

-- 

steve simitzis : /sim' - i - jees/
          pala : saturn5 productions
 www.steve.org : 415.282.9979
  hath the daemon spawn no fire?

