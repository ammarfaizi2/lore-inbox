Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTEFW4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTEFWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:53:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:26554 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262060AbTEFWwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624142572@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624133603@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:54 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1086, 2003/05/06 15:51:03-07:00, greg@kroah.com

PCI Hotplug: export the acpi_resource_to_address64 function, as the acpi pci hotplug driver needs it.


 drivers/acpi/acpi_ksyms.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/acpi/acpi_ksyms.c b/drivers/acpi/acpi_ksyms.c
--- a/drivers/acpi/acpi_ksyms.c	Tue May  6 15:55:41 2003
+++ b/drivers/acpi/acpi_ksyms.c	Tue May  6 15:55:41 2003
@@ -80,6 +80,7 @@
 EXPORT_SYMBOL(acpi_get_possible_resources);
 EXPORT_SYMBOL(acpi_walk_resources);
 EXPORT_SYMBOL(acpi_set_current_resources);
+EXPORT_SYMBOL(acpi_resource_to_address64);
 EXPORT_SYMBOL(acpi_enable_event);
 EXPORT_SYMBOL(acpi_disable_event);
 EXPORT_SYMBOL(acpi_clear_event);

