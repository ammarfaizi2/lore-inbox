Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264452AbUFGQ3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUFGQ3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFGQ3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:29:03 -0400
Received: from fmr06.intel.com ([134.134.136.7]:48306 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264452AbUFGQ3A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:29:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]2.6.7-rc1 Fix and Reenable MSI Support on x86_64
Date: Mon, 7 Jun 2004 09:28:31 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502405570621@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.7-rc1 Fix and Reenable MSI Support on x86_64
Thread-Index: AcRKxBpTHNymEC3VThSjKwPqhFi62AB5tr0w
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, <ak@suse.de>
X-OriginalArrivalTime: 07 Jun 2004 16:28:32.0375 (UTC) FILETIME=[7924B070:01C44CAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 04, 2004 Andrew Morton wrote: 

>>
>> 
>>  MSI support for x86_64 is currently disabled in the kernel 2.6.x.
>>  Below is the patch, which provides a fix and reenable it.
>
>Could you please fix this up?
>
>arch/x86_64/kernel/i8259.c:118: warning: excess elements in array
initializer
>arch/x86_64/kernel/i8259.c:118: warning: (near initialization for
`interrupt')
>
>.config is at http://www.zip.com.au/~akpm/linux/patches/stuff/config

Yes, I am looking into it right now. Please let me know which kernel you
detected these warnings; so, I can repeat these warnings.

Thanks,
Long
