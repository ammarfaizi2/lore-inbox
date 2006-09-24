Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWIXVOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWIXVOI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIXVNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:16 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:14812 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932118AbWIXVNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:09 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jan Engelhardt <jengelh@gmx.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 7/28] kconfig: linguistic fixes for Documentation/kbuild/kconfig-language.txt
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:03 +0200
Message-Id: <11591327053484-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327041093-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>

I have done a look-through through Documentation/kbuild/ and my corrections
(proposed) are attached.

Cc'ed are original author Michael (responsible for comitting changes to
these files?), Sam (kbuild maintainer), Adrian (-trivial maintainer).

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/kbuild/kconfig-language.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
index ca1967f..003fccc 100644
--- a/Documentation/kbuild/kconfig-language.txt
+++ b/Documentation/kbuild/kconfig-language.txt
@@ -67,19 +67,19 @@ applicable everywhere (see syntax).
 - default value: "default" <expr> ["if" <expr>]
   A config option can have any number of default values. If multiple
   default values are visible, only the first defined one is active.
-  Default values are not limited to the menu entry, where they are
-  defined, this means the default can be defined somewhere else or be
+  Default values are not limited to the menu entry where they are
+  defined. This means the default can be defined somewhere else or be
   overridden by an earlier definition.
   The default value is only assigned to the config symbol if no other
   value was set by the user (via the input prompt above). If an input
   prompt is visible the default value is presented to the user and can
   be overridden by him.
-  Optionally dependencies only for this default value can be added with
+  Optionally, dependencies only for this default value can be added with
   "if".
 
 - dependencies: "depends on"/"requires" <expr>
   This defines a dependency for this menu entry. If multiple
-  dependencies are defined they are connected with '&&'. Dependencies
+  dependencies are defined, they are connected with '&&'. Dependencies
   are applied to all other options within this menu entry (which also
   accept an "if" expression), so these two examples are equivalent:
 
@@ -153,7 +153,7 @@ Nonconstant symbols are the most common 
 'config' statement. Nonconstant symbols consist entirely of alphanumeric
 characters or underscores.
 Constant symbols are only part of expressions. Constant symbols are
-always surrounded by single or double quotes. Within the quote any
+always surrounded by single or double quotes. Within the quote, any
 other character is allowed and the quotes can be escaped using '\'.
 
 Menu structure
@@ -237,7 +237,7 @@ choices:
 	<choice block>
 	"endchoice"
 
-This defines a choice group and accepts any of above attributes as
+This defines a choice group and accepts any of the above attributes as
 options. A choice can only be of type bool or tristate, while a boolean
 choice only allows a single config entry to be selected, a tristate
 choice also allows any number of config entries to be set to 'm'. This
-- 
1.4.1

