Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVJWTAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVJWTAl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJWTAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 15:00:14 -0400
Received: from xenotime.net ([66.160.160.81]:48875 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751101AbVJWTAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 15:00:12 -0400
Date: Sun, 23 Oct 2005 11:58:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: [PATCH] kernel-doc: fix PCI hotplug
Message-Id: <20051023115819.2755f13d.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

PCI hotplug.c: does not contain kernel-doc, so don't process it for now.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/DocBook/kernel-api.tmpl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -Naurp linux-2614-rc5/Documentation/DocBook/kernel-api.tmpl~kdoc_pci_hotplug linux-2614-rc5/Documentation/DocBook/kernel-api.tmpl
--- linux-2614-rc5/Documentation/DocBook/kernel-api.tmpl~kdoc_pci_hotplug	2005-10-23 10:36:06.000000000 -0700
+++ linux-2614-rc5/Documentation/DocBook/kernel-api.tmpl	2005-10-23 10:51:43.000000000 -0700
@@ -285,7 +285,9 @@ X!Edrivers/pci/search.c
  -->
 !Edrivers/pci/msi.c
 !Edrivers/pci/bus.c
-!Edrivers/pci/hotplug.c
+<!-- FIXME: Removed for now since no structured comments in source
+X!Edrivers/pci/hotplug.c
+-->
 !Edrivers/pci/probe.c
 !Edrivers/pci/rom.c
      </sect1>


---
