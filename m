Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751086AbWFEM6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWFEM6V (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWFEM6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:58:21 -0400
Received: from mga03.intel.com ([143.182.124.21]:28273 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751065AbWFEM6U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:58:20 -0400
X-IronPort-AV: i="4.05,211,1146466800"; 
   d="scan'208"; a="46127877:sNHT40747287"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-rc5-mm3 -- ACPI errors (are these ones that are significant?)
Date: Mon, 5 Jun 2006 20:58:14 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206F1@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-rc5-mm3 -- ACPI errors (are these ones that are significant?)
Thread-Index: AcaIfuSD0bsiluyoQMuO/XOfBCiQOwAIDfMQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Miles Lane" <miles.lane@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 05 Jun 2006 12:58:15.0442 (UTC) FILETIME=[B5977F20:01C6889F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Mon, 5 Jun 2006 01:24:27 -0700
>"Miles Lane" <miles.lane@gmail.com> wrote:
>
>> During boot:
>> 
>> acpi_processor-0731 [00] processor_preregister_: Error while parsing
>> _PSD domain information. Assuming no coordination
>> 
>> During resume and after the "BUG: sleeping function called from
>> invalid context at include/asm/semaphore.h:99 in_atomic():0,
>> irqs_disabled():1" that I reported earlier:
>> 
>> PM: Finishing wakeup.
>>  acpi: resuming
>> ACPI: read EC, IB not empty
>> ACPI: read EC, OB not full
>> ACPI Exception (evregion-0412): AE_TIME, Returned by Handler for
>> [EmbeddedControl] [20060310]
>> ACPI Exception (dswexec-0459): AE_TIME, While resolving operands for
>> [Store] [20060310]
>> ACPI Error (psparse-0522): Method parse/execution failed
>> [\_TZ_.THRM._TMP] (Node c189ec44), AE_TIME
>> agpgart-intel 0000:00:00.0: resuming
>
>Please copy linux-acpi on acpi-related problems.

Please try boot option: ec_intr=0.
Also, please file a bug report on bugzilla.kernel.org

Thanks,
Luming
