Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265551AbTFMWAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbTFMWAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:00:03 -0400
Received: from fmr01.intel.com ([192.55.52.18]:60670 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265551AbTFMV77 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:59:59 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e1000 performance hack for ppc64 (Power4)
Date: Fri, 13 Jun 2003 15:13:44 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D934@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 performance hack for ppc64 (Power4)
Thread-Index: AcMxvbsUnQpOXBzUQb6tJV3GmxYJgwANPRPQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Herman Dierks" <hdierks@us.ibm.com>
Cc: "David Gibson" <dwg@au1.ibm.com>, <linux-kernel@vger.kernel.org>,
       "Anton Blanchard" <anton@samba.org>,
       "Nancy J Milliner" <milliner@us.ibm.com>,
       "Ricardo C Gonzalez" <ricardoz@us.ibm.com>,
       "Brian Twichell" <twichell@us.ibm.com>
X-OriginalArrivalTime: 13 Jun 2003 22:13:45.0229 (UTC) FILETIME=[0E4163D0:01C331F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So in summary I think this is mainly an alignment issue and 
> it is likely to help other platforms as well so should be 
> considered for the driver.

But we're applying the alignment constraint in the wrong direction.  The
e1000 h/w doesn't have an alignment constraint, it's your arch.  Dave
Hansen's suggestion is in the right direction; let's see what Anton's
response is.

-scott
