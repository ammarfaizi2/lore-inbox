Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRBJK5k>; Sat, 10 Feb 2001 05:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbRBJK5b>; Sat, 10 Feb 2001 05:57:31 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2564 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129166AbRBJK5P>; Sat, 10 Feb 2001 05:57:15 -0500
Date: Sat, 10 Feb 2001 04:51:30 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [ANNOUNCE] PCI-SCI Dolphin Drivers 1.2-2 Released
Message-ID: <20010210045130.A877@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux Kernel,

The Dolphin PCI-SCI Scalable Coherent Interface drivers v1.2-2 
have been posted at vger.timpanogas.org:/sci/pci-sci-1.2-2 and are 
avaialble for download in tar.gz and .src.rpm (RedHat Package Manager)
formats.  These drivers are released under the GPL, and are freely 
redistributable in both tar.gz and RPM formats.

Please direct any comments or bug reports to jmerkey@timpanogas.org
or linux-kernel@vger.kernel.org.

NOTES:

This release has some minor changes to the RPM spec files to support 
cloned installs more easily.  The scripts have been updated to perform 
a 'uname -r' search for the linux kernel source tree, and will 
automatically create a symbolic link during .src.rpm builds or rebuild 
if one does not exist to /usr/src/linux.

The RPM specs have also been made a little smarter, and will allow
binary RPM packages to install in cloned systems that have not been 
previoulsy installed with a complete kernel source tree.  

These changes are useful for folks who build the rpm drivers on 
a master system, then wish to simply perform a binary RPM install
onto a series of cloned cluster nodes without requiring a fully
configured Linux source tree to be present on each target system. 

This release also corrects an SMP/non-SMP autodetection error when
attempting to install binary RPM drivers onto a system that does 
not have a properly configured kernel source tree present.  

Jeff Merkey
Chief Engineer, TRG


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
