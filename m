Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264159AbUFIUD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUFIUD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUFIUD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:03:26 -0400
Received: from fmr06.intel.com ([134.134.136.7]:51423 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264159AbUFIUDY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:03:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: 2.6.7-rc3-mm1
Date: Wed, 9 Jun 2004 13:03:15 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024055CD5F0@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: 2.6.7-rc3-mm1
Thread-Index: AcROXMzmTnbX/UarRK6yL6uGiwxhVw==
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 09 Jun 2004 20:03:16.0946 (UTC) FILETIME=[CDC5B320:01C44E5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 09, 2004 10:05 AM, William Lee Irwin III wrote:

>On Wed, Jun 09, 2004 at 01:35:15PM -0300, Norberto Bensa wrote:
>>   CC      drivers/pci/msi.o
>> drivers/pci/msi.c: In function `msi_address_init':
>> drivers/pci/msi.c:265: error: invalid operands to binary <<
>> make[2]: *** [drivers/pci/msi.o] Error 1
>> make[1]: *** [drivers/pci] Error 2
>> make: *** [drivers] Error 2
>> The offending line is:
>> 
>>         msi_address->lo_address.value |= (MSI_TARGET_CPU <<
MSI_TARGET_CPU_SHIFT);
>
>The MSI writers have a lot to answer for. Could you test this?

I am looking into it now. 

Thanks,
Long
