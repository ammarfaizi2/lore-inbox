Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbSBCO0D>; Sun, 3 Feb 2002 09:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSBCOZy>; Sun, 3 Feb 2002 09:25:54 -0500
Received: from dsl-213-023-060-033.arcor-ip.net ([213.23.60.33]:49423 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S287254AbSBCOZr>;
	Sun, 3 Feb 2002 09:25:47 -0500
Date: Sun, 3 Feb 2002 15:29:13 +0100
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: fixup descriptions in pci-pc.c
Message-ID: <20020203152913.A533@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Ok, this is just a cosmetic thing, but I see that in 2.5.3 the printk 
text in pci_fixup_via_northbridge_bug in pci-pc.c was changed

- printk("Trying to stomp on VIA Northbridge bug...\n");
+ printk("Disabling broken memory write queue.\n");

	Can't we change this to some meaningful output in 2.4.18 as well? It's 
still the old text with pre7.

Bye

Oliver

-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
