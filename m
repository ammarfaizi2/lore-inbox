Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131753AbQL3NZB>; Sat, 30 Dec 2000 08:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbQL3NYv>; Sat, 30 Dec 2000 08:24:51 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:46287 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131753AbQL3NYj>; Sat, 30 Dec 2000 08:24:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 30 Dec 2000 04:54:13 -0800
Message-Id: <200012301254.EAA03620@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.0-test13-pre6 undefined symbols: prepare_etherdev, publish_netdev
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It looks like 2.4.0-test13-pre6 contains a partially applied
patch in net/atm/lec.c.  It adds references to the symbols
prepare_etherdev and publish_netdev, which are not defined anywhere.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
