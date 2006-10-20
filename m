Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946378AbWJTL5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946378AbWJTL5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 07:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946408AbWJTL5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 07:57:48 -0400
Received: from mga03.intel.com ([143.182.124.21]:61526 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1946378AbWJTL5r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 07:57:47 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,333,1157353200"; 
   d="scan'208"; a="133660437:sNHT22186269"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino: ENODEV
Date: Fri, 20 Oct 2006 04:56:06 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A971@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino: ENODEV
Thread-Index: Acb0GivbdIVcp2x4Qey1VkAdxT+LbQAJCYrw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: "Jiri Slaby" <jirislaby@gmail.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 20 Oct 2006 11:57:46.0082 (UTC) FILETIME=[F4EADC20:01C6F43E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Sune Mølgaard [mailto:sune@molgaard.org] 
>Sent: Friday, October 20, 2006 12:34 AM
>To: Pallipadi, Venkatesh
>Cc: Jiri Slaby; Linux kernel mailing list; linux-acpi@vger.kernel.org
>Subject: Re: speedstep-centrino: ENODEV
>
>Pallipadi, Venkatesh wrote:
>> Make sure you have properly configured speedstep-centrino 
>(You should select X86_SPEEDSTEP_CENTRINO_ACPI along with 
>X86_SPEEDSTEP_CENTRINO).
>
>I have enabled all options in the make menuconfig menu under cpufreq 
>(except the one marked deprecated). Still no go :-(
>

Hmm... You must have CPU_FREQ_DENUG enabled in CONFIG already. Can you pass cpufreq.debug=3 in boot option and send me the output of dmesg after that.

Thanks,
Venki
