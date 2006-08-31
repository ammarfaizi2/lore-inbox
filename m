Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWHaMQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWHaMQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWHaMQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:16:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751610AbWHaMQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:16:05 -0400
Date: Thu, 31 Aug 2006 14:15:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com
Subject: ibm-acpi documentation: delete irrelevant "how to compile external module"
Message-ID: <20060831121554.GV3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ibm-acpi documentation contains parts that are no longer relevant
because ibm-acpi was merged.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index 8b3fd82..8d57efa 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -52,40 +52,7 @@ Installation
 
 If you are compiling this driver as included in the Linux kernel
 sources, simply enable the CONFIG_ACPI_IBM option (Power Management /
-ACPI / IBM ThinkPad Laptop Extras). The rest of this section describes
-how to install this driver when downloaded from the web site.
-
-First, you need to get a kernel with ACPI support up and running.
-Please refer to http://acpi.sourceforge.net/ for help with this
-step. How successful you will be depends a lot on you ThinkPad model,
-the kernel you are using and any additional patches applied. The
-kernel provided with your distribution may not be good enough. I
-needed to compile a 2.6.7 kernel with the 20040715 ACPI patch to get
-ACPI working reliably on my ThinkPad X40. Old ThinkPad models may not
-be supported at all.
-
-Assuming you have the basic ACPI support working (e.g. you can see the
-/proc/acpi directory), follow the following steps to install this
-driver:
-
-	- unpack the archive:
-
-		tar xzvf ibm-acpi-x.y.tar.gz; cd ibm-acpi-x.y
-
-	- compile the driver:
-
-		make
-
-	- install the module in your kernel modules directory:
-
-		make install
-
-	- load the module:
-
-		modprobe ibm_acpi
-
-After loading the module, check the "dmesg" output for any error messages.
-
+ACPI / IBM ThinkPad Laptop Extras).
 
 Features
 --------

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
