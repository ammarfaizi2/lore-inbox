Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992535AbWJTHXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992535AbWJTHXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992545AbWJTHXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:23:33 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:46982 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S2992535AbWJTHXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:23:32 -0400
Date: Fri, 20 Oct 2006 09:23:05 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [GIT PATCH] PCI and PCI hotplug fixes for 2.6.19-rc2
Message-ID: <20061020072305.GA4493@aepfle.de>
References: <20061018200238.GA29443@kroah.com> <20061020071241.GA4210@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061020071241.GA4210@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, Olaf Hering wrote:

> On Wed, Oct 18, Greg KH wrote:
> 
> >  .../pci/hotplug => include/linux}/pci_hotplug.h    |    2 
> 
> /home/olaf/kernel/mainline/linux-2.6/drivers/pci/hotplug/rpaphp.h:31:25:
> error: pci_hotplug.h: No such file or directory

Use grep instead of make during interface changes.


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/pci/hotplug/rpaphp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/hotplug/rpaphp.h
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/rpaphp.h
+++ linux-2.6/drivers/pci/hotplug/rpaphp.h
@@ -28,7 +28,7 @@
 #define _PPC64PHP_H
 
 #include <linux/pci.h>
-#include "pci_hotplug.h"
+#include <linux/pci_hotplug.h>
 
 #define DR_INDICATOR 9002
 #define DR_ENTITY_SENSE 9003
