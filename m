Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUDERms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUDERms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:42:48 -0400
Received: from fmr06.intel.com ([134.134.136.7]:10676 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262931AbUDERmr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:42:47 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a problem with 2.6.5-rc3
Date: Mon, 5 Apr 2004 10:41:57 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF5F9A@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a problem with 2.6.5-rc3
Thread-Index: AcQahvfy7Iu7orCfTKSJk7numyuLmQArwmeQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Shawn Starr" <shawn.starr@rogers.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Apr 2004 17:41:58.0001 (UTC) FILETIME=[4B139E10:01C41B35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I try to access the eth0 device I get:
> 
> Apr  4 15:39:01 coredump kernel: NETDEV WATCHDOG: eth0: 
> transmit timed out Apr  4 16:22:12 coredump kernel: NETDEV 
> WATCHDOG: eth0: transmit timed out

Shawn, try turning off ACPI for interrupt routing.  Load the kernel with
the kernel parameter "noapci" set.

-scott
