Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVAJRi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVAJRi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVAJRhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:37:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16007 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262334AbVAJRU7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:20:59 -0500
X-Fake: the user-agent is fake
Subject: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <20050110171827.GA30296@kroah.com>
Date: Mon, 10 Jan 2005 09:20:55 -0800
Message-Id: <11053776551683@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.44, 2005/01/07 10:32:39-08:00, domen@coderock.org

[PATCH] hotplug/acpiphp_ibm: module_param fix

File permissins should be octal number.


Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/acpiphp_ibm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
--- a/drivers/pci/hotplug/acpiphp_ibm.c	2005-01-10 08:59:18 -08:00
+++ b/drivers/pci/hotplug/acpiphp_ibm.c	2005-01-10 08:59:18 -08:00
@@ -47,7 +47,7 @@
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRIVER_VERSION);
-module_param(debug, bool, 644);
+module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, " Debugging mode enabled or not");
 #define MY_NAME "acpiphp_ibm"
 

