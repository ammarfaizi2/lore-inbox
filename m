Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271555AbTGQSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271563AbTGQS2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:28:23 -0400
Received: from fmr03.intel.com ([143.183.121.5]:2554 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S271555AbTGQS1t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:27:49 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] remove pa->va->pa conversion for efi.acpi
Date: Thu, 17 Jul 2003 11:42:38 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE54C@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] remove pa->va->pa conversion for efi.acpi
Thread-Index: AcNMjqSmjtdlwGenSgygxVnCAlyraQAA95Gg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: <davidm@hpl.hp.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jul 2003 18:42:39.0168 (UTC) FILETIME=[32BD5C00:01C34C93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that I'm only pointing this out because I thought there were some
> NULL-pointer checks.  If it's a physical address, 0 is a valid
> address.  If it's an (identity-mapped) kernel address, NULL-pointer
> checks are OK.
> 

Doh!  Yes, indeed.  Thanks...

matt 
