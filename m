Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281607AbRKUGAy>; Wed, 21 Nov 2001 01:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281614AbRKUGAp>; Wed, 21 Nov 2001 01:00:45 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:23771 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S281609AbRKUGAg>; Wed, 21 Nov 2001 01:00:36 -0500
Message-Id: <200111210600.fAL60kE11763@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: linux-kernel@vger.kernel.org
Subject: Mixing 32- and 64-bit cards
Date: Wed, 21 Nov 2001 01:00:33 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in another thread, we are building a file server with 3ware 
IDE RAID.

At the moment, we plan to get a 6800 (32-bit PCI).  If we add 7800's 
(64-bit PCI) or some other 3ware card later, will the driver correctly 
configure them all?  IOW, if I have

32-bit card in 32-bit slot,
32-bit card in 64-bit slot,
64-bit card in 32-bit slot, and
64-bit card in 64-bit slot

all using the same driver, will Linux correctly see 3 32-bit connections 
and one 64-bit?  If this is a driver-level issue, does at least the 3ware 
driver handle this correctly?

Thanks,
	-- Brian
