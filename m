Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbVKWXrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbVKWXrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVKWXqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:29122 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751323AbVKWXqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:33 -0500
Date: Wed, 23 Nov 2005 15:45:09 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       daniel.marjamaki@comhem.se
Subject: [patch 13/22] PCI: direct.c: DBG
Message-ID: <20051123234509.GN527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline; filename="pci-direct.c-dbg.patch"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Marjamäki <daniel.marjamaki@comhem.se>


The DBG() call where updated with the appropriate KERN_* symbol.

Signed-off-by: Daniel Marjamäki <daniel.marjamaki@comhem.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/pci/direct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/arch/i386/pci/direct.c
+++ usb-2.6/arch/i386/pci/direct.c
@@ -201,7 +201,7 @@ static int __init pci_sanity_check(struc
 			return 1;
 	}
 
-	DBG("PCI: Sanity check failed\n");
+	DBG(KERN_WARNING "PCI: Sanity check failed\n");
 	return 0;
 }
 

--
