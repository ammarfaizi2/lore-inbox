Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRKHR3y>; Thu, 8 Nov 2001 12:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRKHR3p>; Thu, 8 Nov 2001 12:29:45 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:25351 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S275778AbRKHR3e>;
	Thu, 8 Nov 2001 12:29:34 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15338.49399.235530.229030@abasin.nj.nec.com>
Date: Thu, 8 Nov 2001 12:29:27 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: Configure.help entry for CONFIG_MD_MULTIPATH
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just spent a bit of time trying to figure out what Multipath I/O
support was because there was no Configure.help entry.  Here is a
slightly modified description of it from Ingo Molnar first post of the
code.  It would of saved me time if it was there.


$ diff -u Configure.copy.help Configure.help
--- Configure.copy.help	Thu Nov  8 10:36:57 2001
+++ Configure.help	Thu Nov  8 12:17:36 2001
@@ -1795,6 +1795,16 @@
 
   If unsure, say Y.
 
+Multipath I/O support
+CONFIG_MD_MULTIPATH
+  Multipath-IO is the ability of certain devices to address the same
+  physical disk over multiple 'IO paths'. The code ensures that such
+  paths can be defined and handled at runtime, and ensures that a
+  transparent failover to the backup path(s) happens if a IO errors
+  arrives on the primary path.
+
+  If unsure, say N.
+
 # AC tree only
 Support for IDE Raid controllers
 CONFIG_BLK_DEV_ATARAID
