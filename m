Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbVKDDqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbVKDDqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbVKDDqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:46:03 -0500
Received: from fmr14.intel.com ([192.55.52.68]:55519 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030592AbVKDDqB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:46:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: NTP broken with 2.6.14
Date: Thu, 3 Nov 2005 22:44:43 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005117C9B@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NTP broken with 2.6.14
Thread-Index: AcXg6nzyiX6IAXQmTNOvEE+ISV3o6AABtNzw
From: "Brown, Len" <len.brown@intel.com>
To: "Jean-Christian de Rivaz" <jc@eclis.ch>,
       "john stultz" <johnstul@us.ibm.com>
Cc: <macro@linux-mips.org>, <linux-kernel@vger.kernel.org>, <dean@arctic.org>,
       <zippel@linux-m68k.org>
X-OriginalArrivalTime: 04 Nov 2005 03:44:53.0743 (UTC) FILETIME=[1DD987F0:01C5E0F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFORCE2 on an ACPI-enabled kernel should automatically invoke
the acpi_skip_timer_override BIOS workaround -- as
the NFORCE family of chip-sets have the timer interrupt
attached to pin-0, but some of them shipped with
a bogus BIOS over-ride telling Linux the timer is on pin-2.

This issue is quite old -- google NFORCE2 and acpi_skip_timer_override.
IIR there are whole web-sites with NFORCE2
workarounds provided by its dedicated fans...

-Len
