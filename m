Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSHOPMD>; Thu, 15 Aug 2002 11:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSHOPMC>; Thu, 15 Aug 2002 11:12:02 -0400
Received: from kim.it.uu.se ([130.238.12.178]:2459 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S317091AbSHOPMC>;
	Thu, 15 Aug 2002 11:12:02 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15707.50603.860391.251920@kim.it.uu.se>
Date: Thu, 15 Aug 2002 17:15:55 +0200
To: linux-kernel@vger.kernel.org
CC: martin@dalecki.de
Subject: 2.5.31 boot failure on pdc20267
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 2.5.31 (non-bk) on hde5, a UDMA(66) Quantum Fireball
on a PDC20267 add-on card, resulted in a complete hang as init
came to its "mount -n -o remount,rw /" point. No visible messages
or anything in the log.

2.5.29 worked ok on this box, as does 2.4 and 2.2+Andre's IDE code.
ASUS P3B-F, 440BX UDMA(33) chipset, disks on a Promise Ultra100 card.
