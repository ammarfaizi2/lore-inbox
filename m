Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWCWDv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWCWDv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWCWDv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:51:57 -0500
Received: from mga03.intel.com ([143.182.124.21]:22171 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965167AbWCWDv4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:51:56 -0500
X-IronPort-AV: i="4.03,120,1141632000"; 
   d="scan'208"; a="14460894:sNHT650410621"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Dual Core on Linux questions
Date: Wed, 22 Mar 2006 19:51:50 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6007A24C57@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dual Core on Linux questions
Thread-Index: AcZOLCDdu+CVxm+dQRWuKghS3+5RnQAAGsWw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jeff Garzik" <jeff@garzik.org>
Cc: "Mattia Dongili" <malattia@linux.it>,
       "Alejandro Bonilla" <abonilla@linuxwireless.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Mar 2006 03:51:51.0690 (UTC) FILETIME=[1E626EA0:01C64E2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Jeff Garzik [mailto:jeff@garzik.org] 
>Sent: Wednesday, March 22, 2006 7:45 PM
>To: Pallipadi, Venkatesh
>Cc: Mattia Dongili; Alejandro Bonilla; linux-kernel@vger.kernel.org
>Subject: Re: Dual Core on Linux questions
>
>Pallipadi, Venkatesh wrote:
>>>From cpufreq perspective multiple things are possible in the way
>> processor will support the multi-core frequency changing. and most of
>> the things are handled at cpufreq inside kernel. I think 
>there should be
>> minima changes required in cpufreqd if any.
>> Options:
>
>
>4) we power down a core.
>

That is more of a logical hotplug issue than cpufreq. But, it is better
to keep the CPU on and scheduler do the best use of it. If CPU has
nothing to run, it will go to deepest C-state possible and idle in that
state anyway. 

Thanks,
Venki
