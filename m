Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292326AbSCDMP3>; Mon, 4 Mar 2002 07:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292329AbSCDMPK>; Mon, 4 Mar 2002 07:15:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54665 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292326AbSCDMPH>;
	Mon, 4 Mar 2002 07:15:07 -0500
Date: Mon, 04 Mar 2002 04:12:52 -0800 (PST)
Message-Id: <20020304.041252.13772021.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA-0.94] Fifth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This release is code named "Ginseng" in honor of the healing
properties it will have for your machine:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.94.patch.gz

Healing list:

[FIX] Some DELL variants not monitoring PHY link status properly.
[FIX] RX ring could still empty and hang chip.  TX/RX paths completely
      revamped.  People please beat on this sucker hard.
[FIX] Jumbo RX buffer sizing wrong.
[FIX] RX ring replenish threshold settings were inaccurate.
[FIX] VLAN layer forgets to set dev->last_rx
[FEATURE] Syskonnect and Altima AC1000 Tigon3's supported.
[FEATURE] Full 5703/5702fe/5702x support.  Please test if you have
	  these chips since we don't :(

Have at it.

How does this thing perform for people?  In particular lmbench
'bw_tcp' and 'lat_tcp' numbers over gigabit on beefy hardware are
considered very interesting...
