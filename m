Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUG2OLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUG2OLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUG2OKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:10:15 -0400
Received: from styx.suse.cz ([82.119.242.94]:30358 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265044AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 42/47] Fix Kconfig so that the joydump module can be compiled
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101963506@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101961806@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.49.1, 2004-06-29 09:48:40+02:00, vojtech@suse.cz
  input: Fix Kconfig so that the joydump module can be compiled.
  
  Reported-by: Matthieu Castet <castetm@ensimag.imag.fr>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
--- a/drivers/input/joystick/Kconfig	Thu Jul 29 14:38:50 2004
+++ b/drivers/input/joystick/Kconfig	Thu Jul 29 14:38:50 2004
@@ -247,7 +247,7 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called amijoy.
 
-config INPUT_JOYDUMP
+config JOYSTICK_JOYDUMP
 	tristate "Gameport data dumper"
 	depends on INPUT && INPUT_JOYSTICK
 	help

