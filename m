Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVLAQpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVLAQpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVLAQpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:45:33 -0500
Received: from fmr22.intel.com ([143.183.121.14]:44474 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932328AbVLAQpd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:45:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add VT flag to cpuinfo
Date: Thu, 1 Dec 2005 08:45:16 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017306158A1B@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add VT flag to cpuinfo
Thread-Index: AcX2khHdCEtH2+EgSj2c/zPKB3njDgABEHBQ
From: "Dugger, Donald D" <donald.d.dugger@intel.com>
To: "Anton Blanchard" <anton@samba.org>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       "Shah, Rajesh" <rajesh.shah@intel.com>, <akpm@osdl.org>
X-OriginalArrivalTime: 01 Dec 2005 16:45:17.0833 (UTC) FILETIME=[9C55E790:01C5F696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I really don't see a conflict here, TLA's for x86
architectures are orthogonal to PowerPC and vice versa
so this shouldn't cause any confusion.

--
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
Donald.D.Dugger@intel.com
Ph: (303)440-1368 

>-----Original Message-----
>From: Anton Blanchard [mailto:anton@samba.org] 
>Sent: Thursday, December 01, 2005 9:10 AM
>To: Dugger, Donald D
>Cc: Andi Kleen; linux-kernel@vger.kernel.org; Shah, Rajesh; 
>akpm@osdl.org
>Subject: Re: [PATCH] Add VT flag to cpuinfo
>
> 
>> Good guess.  We discuessed it and decided that `vmx' was the best
>> term so I'll rework the patch to use that name.
>> 
>> BTW, I don't see any reference to `vmx' in the 2.6.14 tree, is
>> this a change you recently made to your tree?
>
>Unfortunate choice of TLA, VMX is the name for the vector 
>instruction set
>on powerpc (otherwise known as altivec).
>
>Anton
>
