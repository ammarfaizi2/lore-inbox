Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTEEAbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 20:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTEEAbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 20:31:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5594 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261861AbTEEAbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 20:31:52 -0400
Date: Mon, 5 May 2003 02:44:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Sam Ravnborg <sam@ravnborg.org>, kai.germaschewski@gmx.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] document modules_install in "make help"
Message-ID: <20030505004418.GF9794@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds information about modules_install to "make help".

cu
Adrian

--- linux-2.5.68-bk12/Makefile.old	2003-05-04 09:37:20.000000000 +0200
+++ linux-2.5.68-bk12/Makefile	2003-05-04 09:39:44.000000000 +0200
@@ -772,25 +772,26 @@
 
 help:
 	@echo  'Cleaning targets:'
-	@echo  '  clean		- remove most generated files but keep the config'
-	@echo  '  mrproper	- remove all generated files + config + various backup files'
+	@echo  '  clean		  - remove most generated files but keep the config'
+	@echo  '  mrproper	  - remove all generated files + config + various backup files'
 	@echo  ''
 	@echo  'Configuration targets:'
-	@echo  '  oldconfig	- Update current config utilising a line-oriented program'
-	@echo  '  menuconfig	- Update current config utilising a menu based program'
-	@echo  '  xconfig	- Update current config utilising a X-based program'
-	@echo  '  defconfig	- New config with default answer to all options'
-	@echo  '  allmodconfig	- New config selecting modules when possible'
-	@echo  '  allyesconfig	- New config where all options are accepted with yes'
-	@echo  '  allnoconfig	- New minimal config'
+	@echo  '  oldconfig	  - Update current config utilising a line-oriented program'
+	@echo  '  menuconfig	  - Update current config utilising a menu based program'
+	@echo  '  xconfig	  - Update current config utilising a X-based program'
+	@echo  '  defconfig	  - New config with default answer to all options'
+	@echo  '  allmodconfig	  - New config selecting modules when possible'
+	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
+	@echo  '  allnoconfig	  - New minimal config'
 	@echo  ''
 	@echo  'Other generic targets:'
-	@echo  '  all		- Build all targets marked with [*]'
-	@echo  '* vmlinux	- Build the bare kernel'
-	@echo  '* modules	- Build all modules'
-	@echo  '  dir/file.[ois]- Build specified target only'
-	@echo  '  rpm		- Build a kernel as an RPM package'
-	@echo  '  tags/TAGS	- Generate tags file for editors'
+	@echo  '  all		  - Build all targets marked with [*]'
+	@echo  '* vmlinux	  - Build the bare kernel'
+	@echo  '* modules	  - Build all modules'
+	@echo  '  modules_install - Install all modules'
+	@echo  '  dir/file.[ois]  - Build specified target only'
+	@echo  '  rpm		  - Build a kernel as an RPM package'
+	@echo  '  tags/TAGS	  - Generate tags file for editors'
 	@echo  ''
 	@echo  'Documentation targets:'
 	@$(MAKE) --no-print-directory -f Documentation/DocBook/Makefile dochelp
