Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUG2O3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUG2O3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUG2O2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:28:46 -0400
Received: from styx.suse.cz ([82.119.242.94]:26518 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264954AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 28/47] Add Dell SB Live! PCI ID to the emu10k1-gp driver
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110195551@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101952219@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.148.15, 2004-06-23 19:58:19+02:00, vojtech@suse.cz
  input: Add Dell SB Live! PCI ID to the emu10k1-gp driver.
  
  Reported-by: Francisco Moraes <fmoraes74@netzero.net>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 emu10k1-gp.c |    2 ++
 1 files changed, 2 insertions(+)

===================================================================

diff -Nru a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c	Thu Jul 29 14:40:03 2004
+++ b/drivers/input/gameport/emu10k1-gp.c	Thu Jul 29 14:40:03 2004
@@ -50,8 +50,10 @@
 };
 
 static struct pci_device_id emu_tbl[] = {
+ 
 	{ 0x1102, 0x7002, PCI_ANY_ID, PCI_ANY_ID }, /* SB Live gameport */
 	{ 0x1102, 0x7003, PCI_ANY_ID, PCI_ANY_ID }, /* Audigy gameport */
+	{ 0x1102, 0x7004, PCI_ANY_ID, PCI_ANY_ID }, /* Dell SB Live */
 	{ 0, }
 };
 

