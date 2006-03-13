Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWCMTZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWCMTZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWCMTZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:25:30 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:31176 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932344AbWCMTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:25:29 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 13 Mar 2006 20:22:04 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/3] Doc/kernel-parameters.txt: mention modinfo and sysfs
To: linux-kernel@vger.kernel.org
cc: Randy Dunlap <rdunlap@xenotime.net>
In-Reply-To: <tkrat.f6b9032d78fc1d70@s5r6.in-berlin.de>
Message-ID: <tkrat.fb495404c563eaf7@s5r6.in-berlin.de>
References: <tkrat.f6b9032d78fc1d70@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.149) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doc/kernel-parameters.txt: mention modinfo and sysfs

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

--- linux/Documentation/kernel-parameters.txt.1	2006-03-13 19:32:28.000000000 +0100
+++ linux/Documentation/kernel-parameters.txt	2006-03-13 19:57:52.000000000 +0100
@@ -17,6 +17,13 @@
 
 	usbcore.blinkenlights=1
 
+This document may not be entirely up to date and comprehensive. The command
+"modinfo -p ${modulename}" shows a current list of all parameters of a loadable
+module. Loadable modules, after being loaded into the running kernel, also
+reveal their parameters in /sys/module/${modulename}/parameters/. Some of these
+parameters may be changed at runtime by the command
+"echo -n ${value} > /sys/module/${modulename}/parameters/${parm}".
+
 The text in square brackets at the beginning of the description states the
 restrictions on the kernel for the said kernel parameter to be valid. The
 restrictions referred to are that the relevant option is valid if:


