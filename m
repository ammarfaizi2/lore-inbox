Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBGWdq>; Wed, 7 Feb 2001 17:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRBGWd0>; Wed, 7 Feb 2001 17:33:26 -0500
Received: from crl-mail.crl.dec.com ([192.58.206.9]:24080 "EHLO
	crl-mail.crl.dec.com") by vger.kernel.org with ESMTP
	id <S129230AbRBGWdX>; Wed, 7 Feb 2001 17:33:23 -0500
Message-ID: <C88F387E7F6ED4118B5308002BC3EB1E032783@yen.crl.dec.com>
From: Jamey Hicks <jamey@crl.dec.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Cc: linux-hotplug-devel@lists.sourceforge.net
Subject: RE: hotplugging with regular PCI cards
Date: Wed, 7 Feb 2001 17:33:45 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like support for this is available at:

   http://opensource.compaq.com/sourceforge/project/?group_id=13



-Jamey Hicks


-----Original Message-----
From: Adam J. Richter [mailto:adam@yggdrasil.com]
Sent: Wednesday, February 07, 2001 1:08 AM
To: linux-kernel@vger.kernel.org
Cc: linux-hotplug-devel@lists.sourceforge.net
Subject: hotplugging with regular PCI cards


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

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite
104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

_______________________________________________
Linux-hotplug-devel mailing list  http://linux-hotplug.sourceforge.net
Linux-hotplug-devel@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
