Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRC3FBS>; Fri, 30 Mar 2001 00:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRC3FBJ>; Fri, 30 Mar 2001 00:01:09 -0500
Received: from chambertin.convergence.de ([212.84.236.2]:8204 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S130531AbRC3FBA>; Fri, 30 Mar 2001 00:01:00 -0500
Date: Fri, 30 Mar 2001 07:04:29 +0200
To: linux-kernel@vger.kernel.org
Subject: bug in natsemi driver 1.07 for linux 2.4.2
Message-ID: <20010330070429.A20125@teenix.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Sebastian Klemke <packet@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The driver for the natsemi NIC does not properly filter out requested
multicast groups when in multicast mode.  Multicast groups I joined
are simply dropped by the MAC address filter of the card, the kernel
filters them correctly in allmulti or promiscuous mode. I've tested
driver versions 1.05 which comes with linux 2.4.2, an older version
that came with linux-2.4.0test12 and 1.07 which came with 2.4.2-ac20.

I contacted Donald Becker and he told me to post it here.


Read U!

packet
