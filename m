Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUITTKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUITTKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUITTJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:09:59 -0400
Received: from fmr12.intel.com ([134.134.136.15]:57249 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267250AbUITTFe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:05:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: MSI in 2.6.9-rc2-mm1 kernel
Date: Mon, 20 Sep 2004 12:05:23 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502406610519@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MSI in 2.6.9-rc2-mm1 kernel
Thread-Index: AcSdBsoopBY+m1yDS5WMzm/IkdRdxQCPJi1A
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <mikem@beardog.cca.cpqcorp.net>, <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 20 Sep 2004 19:05:24.0704 (UTC) FILETIME=[C8B3DE00:01C49F44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 17, 2004 3:23 PM, Mike Miller wrote:
 
>Has anyone tried an MSI capable device in 2.6.9-rc2-mm1? When
intializing my
>MSI capable controller I get a return value of zero from pci_enable_msi
but
>the system hangs at that point as if I'm not getting the MSI vector.
>
>Just started looking at this, but I was wondering if anyone else has
seen this?

MSI support in 2.6.9-rc2-mm1 kernel works fine for me. It seems that you
should check whether MSI is supported by the platform and processors of
your system. Also, contact the vendor of your MSI device to see whether
a device has any MSI issues, which you are not aware of.

Thanks,
Long  
