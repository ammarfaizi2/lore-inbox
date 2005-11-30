Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVK3Xed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVK3Xed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVK3Xec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:34:32 -0500
Received: from fmr23.intel.com ([143.183.121.15]:33409 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751262AbVK3Xec convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:34:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add VT flag to cpuinfo
Date: Wed, 30 Nov 2005 15:34:19 -0800
Message-ID: <7F740D512C7C1046AB53446D372001730615830E@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add VT flag to cpuinfo
Thread-Index: AcX1+P8HImnhytR/Rqi7pgrGqSYn1AADOZwQ
From: "Dugger, Donald D" <donald.d.dugger@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Shah, Rajesh" <rajesh.shah@intel.com>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 30 Nov 2005 23:34:21.0271 (UTC) FILETIME=[96F39670:01C5F606]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi-

Good guess.  We discuessed it and decided that `vmx' was the best
term so I'll rework the patch to use that name.

BTW, I don't see any reference to `vmx' in the 2.6.14 tree, is
this a change you recently made to your tree?

--
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
Donald.D.Dugger@intel.com
Ph: (303)440-1368 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andi Kleen
>Sent: Wednesday, November 30, 2005 6:53 PM
>To: Dugger, Donald D
>Cc: linux-kernel@vger.kernel.org; Shah, Rajesh; akpm@osdl.org
>Subject: Re: [PATCH] Add VT flag to cpuinfo
>
>donald.d.dugger@intel.com (Donald D Dugger) writes:
>
>> Andrew-
>> 
>> Attached is a trivial patch to 2.6 that will add `vt' to the 
>flags field
>> of `/proc/cpuinfo' for CPUs that have Intel's virtualization 
>technology.
>
>The x86-64 tree already has "vmx" for it. What is the correct
>name? 
>
>-Andi
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
