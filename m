Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbTHBPHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbTHBPHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 11:07:13 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:46557
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S267464AbTHBPHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 11:07:12 -0400
Date: Sat, 2 Aug 2003 11:07:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: marcelo@conectiva.com.br
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [bk patches] 2.4.x RNG doc patches
Message-ID: <20030802150711.GA4316@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These changes are (a) only doc patches and (b) long overdue.


Marcelo, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.4

This will update the following files:

 Documentation/devices.txt  |    2 +-
 Documentation/i810_rng.txt |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/07/06 1.1003.15.2)
   [i810_rng] update docs to reflect new /dev name, and new pkg name

<jgarzik@redhat.com> (03/07/05 1.1003.15.1)
   devices.txt: rename /dev/intel_rng to /dev/hwrandom



diff -Nru a/Documentation/devices.txt b/Documentation/devices.txt
--- a/Documentation/devices.txt	Sat Aug  2 11:05:08 2003
+++ b/Documentation/devices.txt	Sat Aug  2 11:05:08 2003
@@ -384,7 +384,7 @@
 		180 = /dev/vrbuttons	Vr41xx button input device
 		181 = /dev/toshiba	Toshiba laptop SMM support
 		182 = /dev/perfctr	Performance-monitoring counters
-		183 = /dev/intel_rng	Intel i8x0 random number generator
+		183 = /dev/hwrandom	Hardware random number generator (RNG)
 		184 = /dev/cpu/microcode CPU microcode update interface
 		186 = /dev/atomicps	Atomic shapshot of process state data
 		187 = /dev/irnet	IrNET device
diff -Nru a/Documentation/i810_rng.txt b/Documentation/i810_rng.txt
--- a/Documentation/i810_rng.txt	Sat Aug  2 11:05:08 2003
+++ b/Documentation/i810_rng.txt	Sat Aug  2 11:05:08 2003
@@ -10,7 +10,7 @@
 
 	In order to make effective use of this device driver, you
 	should download the support software as well.  Download the
-	latest version of the "intel-rng-tools" package from the
+	latest version of the "rng-tools" package from the
 	i810_rng driver's official Web site:
 
 		http://sourceforge.net/projects/gkernel/
@@ -36,7 +36,7 @@
 	a security-conscious person would run fitness tests on the
 	data before assuming it is truly random.
 
-	/dev/intel_rng is char device major 10, minor 183.
+	/dev/hwrandom is char device major 10, minor 183.
 
 Driver notes:
 
