Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWIPR3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWIPR3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWIPR3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:29:16 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:12888 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964848AbWIPR3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:29:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=rRgo68KX4tw35WJe0pAbA5eYfAx2KMA45jPUj9dOEAqvT6Qo8Fb6nGnSMNGp6oSQOeZKp/DYX9dOattmlDIUEZSdhfM8dV4R/akVYO2R4usl183oNS8NAK7ONhLC/g2GQbp7ljLFrEX1v2uxz0iBxNBhnMOxXA4XbHj4u6CDSQw=
Message-ID: <450C348A.2020907@gmail.com>
Date: Sat, 16 Sep 2006 11:29:46 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch 2.6.18-rc6 ] clocksource:  fix typo in comment (trivial)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fix typo in comment

Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>

--- drivers/clocksource/scx200_hrt.c~	2006-09-16 11:22:57.000000000 -0600
+++ drivers/clocksource/scx200_hrt.c	2006-09-16 11:23:04.000000000 -0600
@@ -63,7 +63,7 @@
 
 static int __init init_hrt_clocksource(void)
 {
-	/* Make sure scx200 has initializedd the configuration block */
+	/* Make sure scx200 has initialized the configuration block */
 	if (!scx200_cb_present())
 		return -ENODEV;
 


