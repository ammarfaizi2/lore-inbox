Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTHWCPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 22:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTHWCPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 22:15:36 -0400
Received: from fmr09.intel.com ([192.52.57.35]:40645 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263586AbTHWCPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 22:15:30 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [patch] 2.4.x ACPI updates
Date: Fri, 22 Aug 2003 22:15:24 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC3@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] 2.4.x ACPI updates
Thread-Index: AcNnTmYCEbJm0YEZQ5+bbEY+94PgtQBCDIoAADExAzA=
From: "Brown, Len" <len.brown@intel.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <acpi-devel@sourceforge.net>
X-OriginalArrivalTime: 23 Aug 2003 02:15:26.0651 (UTC) FILETIME=[6AB148B0:01C3691C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
A small update to what you pulled this morning --
fixes config options CONFIG_ACPI_HT_ONLY and CONFIG_HOTPLUG_PCI_ACPI.

I'm looking forward to deleting these #ifdef CONFIG_ACPI_HT_ONLY
When we can (again) delete acpitable.[ch] in 2.4.23.

Please 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-2.4.22

This 

This will update the following files:

 drivers/hotplug/Config.in |    5 +++--
 include/asm-i386/acpi.h   |    7 +++++++
 include/linux/acpi.h      |    6 ++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (03/08/22 1.1107)
   linux-acpi-2.4.22.patch

ps. the plain patch is also available here:
http://prdownloads.sourceforge.net/acpi/acpi-20030813-2.4.22-rc2.diff?do
wnload
