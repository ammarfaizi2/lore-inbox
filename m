Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276271AbRJCNfs>; Wed, 3 Oct 2001 09:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276270AbRJCNfi>; Wed, 3 Oct 2001 09:35:38 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:10473 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S276266AbRJCNfa>;
	Wed, 3 Oct 2001 09:35:30 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15291.5181.397553.789748@harpo.it.uu.se>
Date: Wed, 3 Oct 2001 15:35:57 +0200
To: linux-kernel@vger.kernel.org
Subject: ne.c (ISA ne2k) problems in 2.4.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any known bugs in the ISA NE2000 driver (drivers/net/ne.c) in
2.4 kernels? I have a remote server that runs mostly unattended. For
various reasons, the NIC to the outside world is an ISA NE2000 (D-link).
This NIC works fine in 2.2 kernels, easily handling months of uptime
and plenty of traffic, but in recent 2.4 kernels, it (NIC or driver)
tends to lock up efter a few days or weeks of uptime. ifdown/ifup
doesn't restore it completely when that happens, but a reboot does.

I could easily exchange the NIC for a 3c509b or an fa310tx rev D, but I
don't know how well those would stand up to these usage patterns.

/Mikael
