Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTLVTdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbTLVTdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:33:35 -0500
Received: from fmr06.intel.com ([134.134.136.7]:44751 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264504AbTLVTdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:33:33 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [OOPS][2.6.0][e100 new driver] mii-diag oops with -F option
Date: Mon, 22 Dec 2003 11:33:08 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102229BE5@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OOPS][2.6.0][e100 new driver] mii-diag oops with -F option
Thread-Index: AcPIuTdfOgApSb5uSlqAUycWRyUoTAACfo9A
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Shawn Starr" <spstarr@sh0n.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Dec 2003 19:33:08.0560 (UTC) FILETIME=[6DAA6500:01C3C8C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> New is a bit non-specific :)  What driver version?

It's got to be the e100-2.3.x driver in 2.6.0.
 
> If you remove all occurences of "__devinit", does the oops go away?

That's the problem.  __devinit's where there shouldn't be __devinit's.

So e100-3.0.x is pending in -exp queue for 2.6.1; do we fix 2.6.0?

-scott
