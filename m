Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUBOA1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUBOA1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 19:27:04 -0500
Received: from fmr05.intel.com ([134.134.136.6]:44473 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263695AbUBOA1B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 19:27:01 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: e1000 problems in 2.6.x
Date: Sat, 14 Feb 2004 16:26:54 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102229F6F@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 problems in 2.6.x
Thread-Index: AcPy7C93E3yy/mxcR6qP2OFxBEmrVQAbi8aw
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Steve Simitzis" <steve@saturn5.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Feb 2004 00:26:54.0950 (UTC) FILETIME=[6A1E9060:01C3F35A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> another oddity is that even after forcing my interfaces to 
> 100 Mbps full duplex, my switch is reporting half duplex. 
> again, this only happens in 2.6.x. when running 2.4.22, full 
> duplex is properly negotiated between the e1000 and my switch.

Are you forcing both the e1000 interfaces and the switch ports to the
same forced settings?  A duplex mismatch would cause problems, but I'm
not sure why this is happening for 2.6 only.  What happens if you don't
force settings, and just rely on autoneg?  (Again, on both ends of the
wire).

-scott
