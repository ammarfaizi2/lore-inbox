Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWATTLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWATTLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWATTFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:25552 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750803AbWATTE7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:04:59 -0500
Cc: bunk@stusta.de
Subject: [PATCH] PCI: schedule PCI_LEGACY_PROC for removal
In-Reply-To: <11377838772370@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:37 -0800
Message-Id: <11377838773155@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: schedule PCI_LEGACY_PROC for removal

PCI_LEGACY_PROC is deprecated since 2.5.53 in favor of lspci(8).

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ba2320f76f3b46144b69ebacedcc03e81107fd9a
tree ed0c786c9b2a1d34680ab1efd01afe5e7dfa7319
parent 3ee68c4af3fd7228c1be63254b9f884614f9ebb2
author Adrian Bunk <bunk@stusta.de> Thu, 29 Dec 2005 20:07:25 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:33 -0800

 Documentation/feature-removal-schedule.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index b4a1ea7..b8143bd 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -148,3 +148,10 @@ Why:	The 8250 serial driver now has the 
 	brother on Alchemy SOCs.  The loss of features is not considered an
 	issue.
 Who:	Ralf Baechle <ralf@linux-mips.org>
+
+---------------------------
+
+What:	Legacy /proc/pci interface (PCI_LEGACY_PROC)
+When:	March 2006
+Why:	deprecated since 2.5.53 in favor of lspci(8)
+Who:	Adrian Bunk <bunk@stusta.de>

