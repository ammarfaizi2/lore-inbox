Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbULGD05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbULGD05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 22:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbULGD05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 22:26:57 -0500
Received: from fmr06.intel.com ([134.134.136.7]:43696 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261751AbULGD0f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 22:26:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI PnP errors
Date: Tue, 7 Dec 2004 11:26:22 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575B63F03@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI PnP errors
Thread-Index: AcTbgpIaa7p4/ciZSEq9ZL1wuCMSPQAid46w
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Meelis Roos" <mroos@linux.ee>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Dec 2004 03:26:30.0913 (UTC) FILETIME=[8B5E0710:01C4DC0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been fixed in Len's tree. Possibly the fix isn't in base kernel.

Shaohua
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Meelis Roos
>Sent: Monday, December 06, 2004 6:53 PM
>To: Linux Kernel list
>Subject: ACPI PnP errors
>
>This is the same Toshiba Satellite 1800-314 laptop that I debugged
>smsc-ircc2 pnp activation on. This time it's plain 2.6.10-rc3 and it
>gives theses errors in dmesg but seems to work:
>
>pnp: PnP ACPI init
>acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object
>[cefcba48]
>acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object
>[cefcb888]
>acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object
>[cefcb608]
>acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object
>[cefcb548]
>acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object
>[cefcb488]
>pnp: PnP ACPI: found 13 devices
>
>--
>Meelis Roos (mroos@linux.ee)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
