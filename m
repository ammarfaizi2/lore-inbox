Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUDFW6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263889AbUDFW6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:58:49 -0400
Received: from fmr01.intel.com ([192.55.52.18]:36049 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262634AbUDFW6q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:58:46 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a problem with 2.6.5-rc3
Date: Tue, 6 Apr 2004 18:58:41 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE002F7B6C6@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a problem with 2.6.5-rc3
Thread-Index: AcQahvfy7Iu7orCfTKSJk7numyuLmQArwmeQAD0v6IA=
From: "Brown, Len" <len.brown@intel.com>
To: "Feldman, Scott" <scott.feldman@intel.com>,
       "Shawn Starr" <shawn.starr@rogers.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Apr 2004 22:58:42.0407 (UTC) FILETIME=[B4FF9770:01C41C2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> When I try to access the eth0 device I get:
>> 
>> Apr  4 15:39:01 coredump kernel: NETDEV WATCHDOG: eth0: 
>> transmit timed out Apr  4 16:22:12 coredump kernel: NETDEV 
>> WATCHDOG: eth0: transmit timed out
>
>Shawn, try turning off ACPI for interrupt routing.  Load the 
>kernel with
>the kernel parameter "noapci" set.

You mean "acpi=off", or "pci=noacpi".  If either of these fix the
problem, please let me know.  (and send me the dmesg and
/proc/interrupts for both cases)

"noapic" (note spelling) would have no effect on this box b/c it is
running in PIC-mode.

Cheers,
-Len
