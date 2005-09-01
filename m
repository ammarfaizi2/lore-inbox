Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVIAUBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVIAUBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVIAUBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:01:30 -0400
Received: from fmr19.intel.com ([134.134.136.18]:62404 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030343AbVIAUBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:01:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH]reconfigure MSI registers after resume
Date: Thu, 1 Sep 2005 13:01:03 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502409A459F1@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH]reconfigure MSI registers after resume
thread-index: AcWvLADh80n0gxQtRDuhx+1TJ/p5KQAA1SNg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <greg@kroah.com>, "Li, Shaohua" <shaohua.li@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2005 20:01:04.0698 (UTC) FILETIME=[E26C01A0:01C5AF2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 01, 2005 12:32 PM Andrew Morton wrote:
> So what is the alternative to Shaohua's fix?  Restore all the msi 
> registers on resume?

Yes, the PCIe port bus driver, for example, did that.

Thanks,
Tom
