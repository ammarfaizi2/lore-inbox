Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWCMT0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWCMT0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWCMT0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:26:51 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39624 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932317AbWCMT0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:26:50 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 13 Mar 2006 20:23:17 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 3/3] Doc/kernel-parameters.txt: slightly reword sentence about
 restrictions
To: linux-kernel@vger.kernel.org
cc: Randy Dunlap <rdunlap@xenotime.net>
In-Reply-To: <tkrat.fb495404c563eaf7@s5r6.in-berlin.de>
Message-ID: <tkrat.db45898acb8b4e93@s5r6.in-berlin.de>
References: <tkrat.f6b9032d78fc1d70@s5r6.in-berlin.de>
 <tkrat.fb495404c563eaf7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.773) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doc/kernel-parameters.txt: slightly reword sentence about restrictions

The previous patch somewhat diverted the train of thought.
Here I am trying to bring the valued reader back on track.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

--- linux/Documentation/kernel-parameters.txt.2	2006-03-13 19:57:52.000000000 +0100
+++ linux/Documentation/kernel-parameters.txt	2006-03-13 20:03:32.000000000 +0100
@@ -24,9 +24,10 @@
 parameters may be changed at runtime by the command
 "echo -n ${value} > /sys/module/${modulename}/parameters/${parm}".
 
-The text in square brackets at the beginning of the description states the
-restrictions on the kernel for the said kernel parameter to be valid. The
-restrictions referred to are that the relevant option is valid if:
+The parameters listed below are only valid if certain kernel build options were
+enabled and if respective hardware is present. The text in square brackets at
+the beginning of each description states the restrictions within wich a
+parameter is applicable:
 
 	ACPI	ACPI support is enabled.
 	ALSA	ALSA sound support is enabled.


