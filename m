Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271284AbTHCVPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271302AbTHCVPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:15:25 -0400
Received: from fmr06.intel.com ([134.134.136.7]:57832 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271284AbTHCVPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:15:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: unknown ethernet device
Date: Sun, 3 Aug 2003 14:15:17 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102229280@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: unknown ethernet device
Thread-Index: AcNZ1IMjbIk4BTROSGuJDlitNwqH4wALz9Dg
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Matt Mercer" <floyd@unpunk.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Aug 2003 21:15:17.0859 (UTC) FILETIME=[56C47330:01C35A04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lspci -s00:04.0 -xxx
> 00:04.0 Ethernet controller: Intel Corp.: Unknown device 0105 (rev 0d)

0105 isn't a valid device ID for e100.  Sounds like a mis-programmed
eeprom.
