Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWDTFpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWDTFpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 01:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWDTFpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 01:45:38 -0400
Received: from mga03.intel.com ([143.182.124.21]:64778 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751270AbWDTFph convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 01:45:37 -0400
X-IronPort-AV: i="4.04,138,1144047600"; 
   d="scan'208"; a="25372746:sNHT15104180"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 13:45:27 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] [PATCH] Make ACPI button driver an input device
Thread-Index: AcZj62Uig3psqOLPTeWyGycPmrEaDwAUUdKQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Apr 2006 05:45:28.0613 (UTC) FILETIME=[A1275550:01C6643D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sleep and power buttons are logically part of the keyboard, 
>and it makes 
>for them to be exposed via an input device rather than an odd file in 
>/proc. This patch adds a keycode for lid switches (are we 
>running out of 
>keycodes?) and allows the button driver to register an input device.

Do you plan to port the whole acpi event interface into input layer?
If so,  keycode is NOT a right way.

--Luming
