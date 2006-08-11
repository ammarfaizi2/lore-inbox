Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWHKTz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWHKTz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWHKTz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:55:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:35852 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964774AbWHKTz4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:55:56 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,115,1154934000"; 
   d="scan'208"; a="107102862:sNHT21398832"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq stops working after a while
Date: Fri, 11 Aug 2006 12:55:51 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq stops working after a while
thread-index: Aca9fqi8glY6Q2WUR+OZvvD2BdrLDQAAWhCg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mark Lord" <lkml@rtr.ca>, "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 11 Aug 2006 19:55:52.0215 (UTC) FILETIME=[2644E270:01C6BD80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Mark Lord
>Sent: Friday, August 11, 2006 12:41 PM
>To: Dave Jones; Linux Kernel; Andrew Morton
>Subject: Re: cpufreq stops working after a while
>
>Dave Jones wrote:
>> 
>> boot with cpufreq.debug=7, and capture dmesg output after it fails
>> to transition.  This might be another manifestation of the mysterious
>> "highest frequency isnt accessable" bug, that seems to come from
>> some recent change in acpi.
>
>booting with that option doesn't seem to give me any new messages
>in dmesg (or /var/log/messages).  I also tried editing cpufreq.c
>and hardcoding debug = 7 on the variable declaration.
>Still no new messages.
>
>??

You also need to configure in CONFIG_CPU_FREQ_DEBUG for the parameter to
take effect.

Thanks,
Venki
