Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311439AbSCNA2q>; Wed, 13 Mar 2002 19:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311448AbSCNA2A>; Wed, 13 Mar 2002 19:28:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28300 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311454AbSCNA01>;
	Wed, 13 Mar 2002 19:26:27 -0500
Date: Wed, 13 Mar 2002 16:23:58 -0800 (PST)
Message-Id: <20020313.162358.110332826.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA-0.97] Eigth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From the usual location:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.97.patch.gz

Changes in this release:

[FIX] Lots of VLAN layer fixes from Chris Leech.
[FIX] Fix a bug in Tigon3 fibre negotiation state machine
      where it could run forever.  Reported by Erik Habbinga.
[FIX] Do not lose network statistics around down/up of interface
      for Tigon3.  Broadcom's driver has this bug too.
[FIX] Small bug fix for PHY setup on 5703 A1 revisions.
[FEATURE] Add many new tunables, via ethtool, to Tigon3
	  for controlling:
	  1) Coelaescing, interrupt mitigation
	  2) RX/TX ring sizes
	  3) Pause flow control settings
	  4) RX/TX checksumming and scatter-gather
	  Please note that these new bits have not been
	  added to Jeff's ethtool userland tool but they
	  will be added soon.

I'm probably going to bump the version to 1.0 and push this to Marcelo
for 2.4.x in the next couple of days.  Jeff has already included this
driver (and I the VLAN layer stuff) into 2.5.x

Enjoy.
