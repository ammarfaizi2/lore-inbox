Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUHAOdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUHAOdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUHAOdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:33:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22746 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265986AbUHAOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:33:13 -0400
Date: Sun, 1 Aug 2004 16:33:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
Subject: [2.6 patch] update NET_SCH_NETEM help text
Message-ID: <20040801143307.GR2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes for the NET_SCH_NETEM 
help text:
- correct the module name
- "If unsure, say N."


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-mm1-full/net/sched/Kconfig.old	2004-08-01 16:28:22.000000000 +0200
+++ linux-2.6.8-rc2-mm1-full/net/sched/Kconfig	2004-08-01 16:29:12.000000000 +0200
@@ -207,19 +207,21 @@
 config NET_SCH_NETEM
 	tristate "Network emulator"
 	depends on NET_SCHED
 	help
 	  Say Y if you want to emulate network delay, loss, and packet
 	  re-ordering. This is often useful to simulate networks when
 	  testing applications or protocols.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called sch_delay.
+	  will be called sch_netem.
+
+	  If unsure, say N.
 
 config NET_SCH_INGRESS
 	tristate "Ingress Qdisc"
 	depends on NET_SCHED 
 	help
 	  If you say Y here, you will be able to police incoming bandwidth
 	  and drop packets when this bandwidth exceeds your desired rate.
 	  If unsure, say Y.
 

