Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293229AbSCKAos>; Sun, 10 Mar 2002 19:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293249AbSCKAoi>; Sun, 10 Mar 2002 19:44:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52664 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293229AbSCKAoc>;
	Sun, 10 Mar 2002 19:44:32 -0500
Date: Sun, 10 Mar 2002 16:41:13 -0800 (PST)
Message-Id: <20020310.164113.01028736.davem@redhat.com>
To: laforge@gnumonks.org
Cc: skraw@ithnet.com, joe@tmsusa.com, linux-kernel@vger.kernel.org,
        elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020310163339.H16784@sunbeam.de.gnumonks.org>
In-Reply-To: <3C6D1E99.6070303@tmsusa.com>
	<20020227151218.78965262.skraw@ithnet.com>
	<20020310163339.H16784@sunbeam.de.gnumonks.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Harald Welte <laforge@gnumonks.org>
   Date: Sun, 10 Mar 2002 16:33:39 +0100
   
   You can buy bcm57xx based boards, where the chipset is nice but the driver
   not really nice yet.
   
My tg3 driver sucks then right?  Could you send me a bug report?

   You can buy syskonnect sk98 boards, which definitely have a good chipset - 
   but the driver doesn't support the tcp transmit zerocopy path yet.  I've
   tried to put some pressure on SysKonnect about this - but they seem a bit
   'slow'.
   
The hardware is not capable of doing it, due to bugs in the hw
checksum implementation of the sk98 chipset.  They aren't being
"slow" they just can't possibly implement it for you.

Franks a lot,
David S. Miller
davem@redhat.com
