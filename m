Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWANHCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWANHCk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 02:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWANHCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 02:02:40 -0500
Received: from xenotime.net ([66.160.160.81]:60065 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751728AbWANHCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 02:02:39 -0500
Date: Fri, 13 Jan 2006 23:02:37 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: akpm <akpm@osdl.org>
Cc: buraphalinuxserver@gmail.com, linux-kernel@vger.kernel.org, okir@suse.de
Subject: [PATCH] nlm kernel-parameters update
Message-Id: <20060113230237.3c5983d6.rdunlap@xenotime.net>
In-Reply-To: <20060113223309.011188f1.rdunlap@xenotime.net>
References: <5d75f4610601132130s4870d9eaq9261450905d6b888@mail.gmail.com>
	<20060113223309.011188f1.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add 2 lockd kernel parameters and spell 2 others correctly.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-parameters.txt |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

--- linux-2615-g9.orig/Documentation/kernel-parameters.txt
+++ linux-2615-g9/Documentation/kernel-parameters.txt
@@ -712,9 +712,17 @@ running once the system is up.
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy
 			See Documentation/ramdisk.txt.
 
-	lockd.udpport=	[NFS]
+	lockd.nlm_grace_period=P  [NFS] Assign grace period.
+			Format: <integer>
+
+	lockd.nlm_tcpport=N	[NFS] Assign TCP port.
+			Format: <integer>
 
-	lockd.tcpport=	[NFS]
+	lockd.nlm_timeout=T	[NFS] Assign timeout value.
+			Format: <integer>
+
+	lockd.nlm_udpport=M	[NFS] Assign UDP port.
+			Format: <integer>
 
 	logibm.irq=	[HW,MOUSE] Logitech Bus Mouse Driver
 			Format: <irq>


---
