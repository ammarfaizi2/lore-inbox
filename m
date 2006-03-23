Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWCWDrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWCWDrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWCWDrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:47:24 -0500
Received: from mga03.intel.com ([143.182.124.21]:62769 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965123AbWCWDrW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:47:22 -0500
X-IronPort-AV: i="4.03,120,1141632000"; 
   d="scan'208"; a="14460091:sNHT179352964"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: ACPI error in 2.6.16 (AE_TIME, Returned by Handler for EmbeddedControl)
Date: Thu, 23 Mar 2006 11:46:31 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B468EFD@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI error in 2.6.16 (AE_TIME, Returned by Handler for EmbeddedControl)
Thread-Index: AcZOJjiFe6gjhUkFRIyrQp+uCySakwABcWLw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Francesco Biscani" <biscani@pd.astro.it>,
       "Brown, Len" <len.brown@intel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>, "Jiri Slaby" <slaby@liberouter.org>
X-OriginalArrivalTime: 23 Mar 2006 03:46:33.0151 (UTC) FILETIME=[60853CF0:01C64E2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thursday 23 March 2006 02:45, Brown, Len wrote:
>> does this go away if you boot with "ec_intr=0"?
>
>So far it seems like that option solves the problem. But since 
>the bug appears 
>very erratically I think it's better to wait for a few more reboots.
>
>BTW, when I was testing _without_ ec_intr=0 I got this in the 
>log (this 
>happened the first reboot after the one mentioned in my previous mail):
>
>Mar 23 03:48:50 kurtz ACPI: read EC, IB not empty
>Mar 23 03:48:50 kurtz ACPI: read EC, OB not full
>Mar 23 03:48:50 kurtz ACPI Exception (evregion-0409): AE_TIME, 
>Returned by 
>Handler for [EmbeddedControl] [20060127]
>Mar 23 03:48:50 kurtz ACPI Exception (dswexec-0458): AE_TIME, 
>While resolving 
>operands for [AE_NOT_CONFIGURED] [20060127]
>Mar 23 03:48:50 kurtz ACPI Error (psparse-0517): Method 
>parse/execution failed 
>[\_SB_.PCI0.ISA_.EC0_._Q20] (Node c13ecbc0), AE_TIME
>
>This is an hp pavilion ze5616ea laptop, FYI.
>
>Thanks and best regards,
>
>  Francesco

Please file this bug on bugzilla.kernel.org
We need to find out why ?
Could you post dmesg for ec_intr=0 , ec_intr=1 on bugzilla.


Thanks,
Luming

