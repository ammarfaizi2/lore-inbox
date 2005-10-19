Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVJSBiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVJSBiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVJSBhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:37:16 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:32787 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932438AbVJSBdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:09 -0400
Date: Tue, 18 Oct 2005 21:31:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, shemminger@osdl.org, mlindner@syskonnect.de,
       rroesler@syskonnect.de
Subject: [patch 2.6.14-rc4 3/3] Documentation: add sk98lin to the feature-removal-schedule
Message-ID: <10182005213100.12480@bilbo.tuxdriver.com>
In-Reply-To: <10182005213100.12420@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sk98lin and skge drivers cover the same set of hardware, yet the
sk98lin driver is barely maintained.  This patch schedules sk98lin
for removal early next year.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 files changed, 9 insertions(+)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -95,3 +95,12 @@ Why:	This interface has been obsoleted b
 	to link against API-compatible library on top of libnfnetlink_queue 
 	instead of the current 'libipq'.
 Who:	Harald Welte <laforge@netfilter.org>
+
+---------------------------
+
+What:	sk98lin driver
+When:	April 2006
+Why:	This driver has been essentially unmaintained for some time.
+	Internally it is a mess, and the original authors are unwilling to
+	correct it.  Now the skge driver covers all the same hardware.
+Who:	John W. Linville <linville@tuxdriver.com>
