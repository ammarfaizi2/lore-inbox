Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbRBBVrK>; Fri, 2 Feb 2001 16:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBBVrA>; Fri, 2 Feb 2001 16:47:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65031 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129049AbRBBVqu>; Fri, 2 Feb 2001 16:46:50 -0500
Date: Fri, 2 Feb 2001 15:41:29 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] PCI-SCI Drivers v1.1-6 released
Message-ID: <20010202154129.A2911@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux Kernel,

(Sorry, had one more change that did not make the patch.  this release
contains the corrected patch).

Version 1.1-6 of the Dolphin PCI-SCI (Scalable Coherent Interface) drivers
for Linux kernels 2.2.X and 2.4.X have been posted at 
vger.timpanogas.org:/sci.  These drivers are freely available under
the GNU public license and are provided in both RPM and tar.gz 
formats.

NOTES: 

This release corrects an SMP/non-SMP auto-detection problem during 
driver install. If someone is using an SMP kernel on a single processor
system, this version checks the kernel build tree to determine which 
option was built with the drivers in the /usr/src/linux/.config 
file prior to installing the drivers.

This version corrects a reported bug for those folks who compile 
an SMP kernel on a APIC supported single CPU system during driver
install.

Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
