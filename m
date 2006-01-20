Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWATTL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWATTL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWATTLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:11:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:38608 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932072AbWATTFI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:08 -0500
Cc: ricknu-0@student.ltu.se
Subject: [PATCH] pci: Schedule removal of pci_module_init
In-Reply-To: <11377838773155@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:37 -0800
Message-Id: <1137783877218@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pci: Schedule removal of pci_module_init

Scheduled the removal of pci_module_init.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e63ee95d25ba6663180153b7533f9c0fe77eb9dd
tree 681c68b11871411bac7fe9495b2a529ee6cd5f4e
parent ba2320f76f3b46144b69ebacedcc03e81107fd9a
author Richard Knutsson <ricknu-0@student.ltu.se> Sat, 03 Dec 2005 02:34:12 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:33 -0800

 Documentation/feature-removal-schedule.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index b8143bd..4d4897c 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -155,3 +155,10 @@ What:	Legacy /proc/pci interface (PCI_LE
 When:	March 2006
 Why:	deprecated since 2.5.53 in favor of lspci(8)
 Who:	Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
+What:	pci_module_init(driver)
+When:	January 2007
+Why:	Is replaced by pci_register_driver(pci_driver).
+Who:	Richard Knutsson <ricknu-0@student.ltu.se> and Greg Kroah-Hartman <gregkh@suse.de>

