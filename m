Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUACMgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 07:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUACMgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 07:36:50 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:53632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261190AbUACMgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 07:36:49 -0500
Date: Sat, 3 Jan 2004 13:37:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       len.brown@intel.com
Subject: ACPI: document acpi_sleep option
Message-ID: <20040103123755.GA387@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

acpi_sleep option should be documented, too. Please apply.

								Pavel

Index: linux.new/Documentation/kernel-parameters.txt
===================================================================
--- linux.new.orig/Documentation/kernel-parameters.txt	2003-12-25 13:28:48.000000000 +0100
+++ linux.new/Documentation/kernel-parameters.txt	2003-12-25 13:29:08.000000000 +0100
@@ -90,6 +90,10 @@
 			off -- disabled ACPI for systems with default on
 			ht -- run only enough ACPI to enable Hyper Threading
 			See also Documentation/pm.txt.
+
+	acpi_sleep=	[HW,ACPI] Sleep options
+			Format: { s3_bios, s3_mode }
+			See Documentation/power/video.txt
  
 	ad1816=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
