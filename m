Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273076AbTHFCEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273111AbTHFCEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:04:52 -0400
Received: from fmr05.intel.com ([134.134.136.6]:8912 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S273076AbTHFCEv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:04:51 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: More 2.4.22pre10 ACPI breakage
Date: Tue, 5 Aug 2003 19:04:48 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E01022292CD@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More 2.4.22pre10 ACPI breakage
Thread-Index: AcNbtN2/ljPGLo7kRhiOgsBtrrOlngACeMYA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Samuel Flory" <sflory@rackable.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Aug 2003 02:04:49.0493 (UTC) FILETIME=[1DE4F050:01C35BBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   It appears that the intel Se7501BR mother is also having 
> issues with ACPI.  When ACPI support is enable the e1000
> controller stops working printing "<6>NETDEV WATCHDOG:
> eth0: transmit timed out".

Must...have...interrupts.  Confirm by watching /proc/interrupts for that
ethX.

-scott
