Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129488AbRBGGIX>; Wed, 7 Feb 2001 01:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129592AbRBGGIO>; Wed, 7 Feb 2001 01:08:14 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:51397 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129488AbRBGGIH>; Wed, 7 Feb 2001 01:08:07 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 6 Feb 2001 22:08:06 -0800
Message-Id: <200102070608.WAA08283@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: hotplugging with regular PCI cards
Cc: linux-hotplug-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I saw an interesting demonstration at LinuxWorld last week.
Compaq had a machine that did hot plugging with regular PCI cards (not
Compact PCI).  If anyone out there is familiar with this machine,
I would be interested in knowing what the status is on getting
the support for that backplain integrated into the stock kernels.

	When that occurs, that will be yet another reason to treat all
new style PCI drivers as potentially hot pluggable, even if those cards
are not currently available in a CardBus or CompactPCI form, and in
particular to change all of the xxx_pci_tbl declarations in PCI
drivers that are currently marked as __initdata back to __devinitdata.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
