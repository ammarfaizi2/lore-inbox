Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270545AbUJUD27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270545AbUJUD27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270527AbUJUD2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:28:11 -0400
Received: from fmr05.intel.com ([134.134.136.6]:26341 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269097AbUJUDHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:07:10 -0400
Subject: [PATCH 0/5]ACPI and PNP
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Content-Type: text/plain
Message-Id: <1098327554.6132.218.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 10:59:15 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
ACPI is supposed to replace legacy PNPBIOS. The patches (I'll send them
follow this mail) introduce ACPI PNP layer and make ACPI work with
legacy devices better (such as avoid resources conflict between PNP
devices and PCI devices). With the patches, some ACPI drivers such as
8250_acpi, ACPI motherboard driver can be removed, since now we have a
unified interface for PNPBios and ACPI PNP. The patches are against
2.6.9 and tested at both IA32 and IA64. Please give your comments.

Thanks,
Shaohua

