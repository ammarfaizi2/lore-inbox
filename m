Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280712AbRKOEAp>; Wed, 14 Nov 2001 23:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280714AbRKOEAe>; Wed, 14 Nov 2001 23:00:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55453 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280712AbRKOEA2>;
	Wed, 14 Nov 2001 23:00:28 -0500
Date: Wed, 14 Nov 2001 23:00:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [RFC] races in access to pci_devices
Message-ID: <Pine.GSO.4.21.0111142257510.1095-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, as far as I can see there's no exclusion between
the code that walks pci_devices and pci_insert_device().  It's
not a big deal wrt security (not many laptops with remote access)
but...

	What locking is supposed to be there?

