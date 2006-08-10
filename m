Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWHJJgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWHJJgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWHJJgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:36:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:12728 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751421AbWHJJgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:36:23 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,109,1154934000"; 
   d="scan'208"; a="106156309:sNHT17757194"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Date: Thu, 10 Aug 2006 05:36:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60133D741@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Thread-Index: Aca8GRGtHsWZfyd/QCa4XQ5HlcCg4gARlNTw
From: "Brown, Len" <len.brown@intel.com>
To: "Lennart Poettering" <mzxreary@0pointer.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2006 09:36:11.0136 (UTC) FILETIME=[6A34B800:01C6BC60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart,

Your s270 platform driver needs a different home in the source tree
outside of drivers/acpi/, and the patch that adds it must add an entry
to MAINTAINERS.

lcd brightness platform support should talk to the existing
backlight stuff under sysfs.

wlan and bluetooth indicators/controls need to appear under
generic places under sysfs -- not under platform specific
files under /proc/acpi.

Yes, the existing platform specific drivers such as asus, toshiba, and
ibm
are bad examples.

thanks,
-Len
