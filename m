Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSCDBfP>; Sun, 3 Mar 2002 20:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSCDBfG>; Sun, 3 Mar 2002 20:35:06 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:36875
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S290796AbSCDBe4>; Sun, 3 Mar 2002 20:34:56 -0500
Date: Mon, 4 Mar 2002 02:34:30 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: linux-kernel@vger.kernel.org
Cc: Manfred Spraul <manfred@colorfullife.com>,
        "Patrick R. McManus" <mcmanus@ducksong.com>
Subject: [PATCH] SiS IDE, several fixes
Message-ID: <20020304023430.A26562@bouton.inet6-interne.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Manfred Spraul <manfred@colorfullife.com>,
	"Patrick R. McManus" <mcmanus@ducksong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

found time to read e-mails and write code.

- 730 fix (this ATA100 chipset uses the ATA66 family register layout)
- Hang if UDMA is not set by BIOS fix (thanks to Manfred Spraul)

If you have a 730 chipset or if you couldn't boot without ide=nodma please
test latest patch and report the results to me.

Patch against 2.4.18:

http://inet6.dyn.dhs.org/sponsoring/sis5513/sis.patch.20020304_1
or
http://gyver.homeip.net/sis5513/sis.patch.20020304_1

Full driver (drop-in replacement of linux/drivers/ide):

http://inet6.dyn.dhs.org/sponsoring/sis5513/sis5513-v0.13.c
or
http://gyver.homeip.net/sis5513/sis5513-v0.13.c

LB.
