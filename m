Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSEGHGJ>; Tue, 7 May 2002 03:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSEGHGI>; Tue, 7 May 2002 03:06:08 -0400
Received: from ns.tasking.nl ([195.193.207.2]:12037 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S315370AbSEGHGI>;
	Tue, 7 May 2002 03:06:08 -0400
To: linux-kernel@vger.kernel.org
Subject: 3c59x: LK1.1.17 gives No MII transceivers found
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <rnews@altium.nl>
Date: 07 May 2002 09:03:21 +0200
Message-ID: <sik7qgo2x2.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.8 there was an update of the 3c59x driver. I have two NICs,
both use this driver, a 3c900 Boomerang and a 3c905C Tornado.

Linux 2.4.17 and 2.5.7 both report
00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.16
00:09.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.16

However, the new driver produces:
00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.17
phy=0, phyx=24, mii_status=0xffff
phy=1, phyx=0, mii_status=0xffff
phy=2, phyx=1, mii_status=0xffff
phy=3, phyx=2, mii_status=0xffff
phy=4, phyx=3, mii_status=0xffff
phy=5, phyx=4, mii_status=0xffff
phy=6, phyx=5, mii_status=0xffff
phy=7, phyx=6, mii_status=0xffff
phy=8, phyx=7, mii_status=0xffff
phy=9, phyx=8, mii_status=0xffff
phy=10, phyx=9, mii_status=0xffff
phy=11, phyx=10, mii_status=0xffff
phy=12, phyx=11, mii_status=0xffff
phy=13, phyx=12, mii_status=0xffff
phy=14, phyx=13, mii_status=0xffff
phy=15, phyx=14, mii_status=0xffff
phy=16, phyx=15, mii_status=0xffff
phy=17, phyx=16, mii_status=0xffff
phy=18, phyx=17, mii_status=0xffff
phy=19, phyx=18, mii_status=0xffff
phy=20, phyx=19, mii_status=0xffff
phy=21, phyx=20, mii_status=0xffff
phy=22, phyx=21, mii_status=0xffff
phy=23, phyx=22, mii_status=0xffff
phy=24, phyx=23, mii_status=0xffff
phy=25, phyx=25, mii_status=0xffff
phy=26, phyx=26, mii_status=0xffff
phy=27, phyx=27, mii_status=0xffff
phy=28, phyx=28, mii_status=0xffff
phy=29, phyx=29, mii_status=0xffff
phy=30, phyx=30, mii_status=0xffff
phy=31, phyx=31, mii_status=0xffff
  ***WARNING*** No MII transceivers found!
00:09.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.17
phy=0, phyx=24, mii_status=0x782d

Does anybody have a clue what can be wrong? Any help would be
appreciated.

      Kees
