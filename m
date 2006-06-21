Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWFUT2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWFUT2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWFUT2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:28:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:22168 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751299AbWFUT2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:28:00 -0400
X-IronPort-AV: i="4.06,163,1149490800"; 
   d="scan'208"; a="56374226:sNHT171943982"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq doesn't work with my Intel Pentium M processor in 2.6.17
Date: Wed, 21 Jun 2006 12:27:54 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454192D25@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq doesn't work with my Intel Pentium M processor in 2.6.17
thread-index: AcaTZphJ6rNJ7Xc/S3y7I+6SxVkqsACAeqbQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "CIJOML" <cijoml@volny.cz>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Jun 2006 19:27:55.0653 (UTC) FILETIME=[CBE49350:01C69568]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of CIJOML
>Sent: Sunday, June 18, 2006 11:06 PM
>To: linux-kernel@vger.kernel.org
>Subject: cpufreq doesn't work with my Intel Pentium M 
>processor in 2.6.17
>
>Hello team,
>
>I compiled 2.6.17 and now I see, that cpufreq doesn't work 
>with 2.6.17 (2.6.16 
>was fine).
>
>My cpu:
>Intel(R) Pentium(R) M processor 1.70GHz
>cpu family 6
>model 13
>stepping 6
>
>Cpufreq doesn't start and also /sys files are not present/created
>
>My config:
>[*] CPU Frequency scaling
><*> CPU frequency translation statistics
>[*] CPU frequency translation statistics details
>governors: <*> performance, powersave, ondemand, conservative
><*> Intel Enhanced SpeedStep
>[*] Use ACPI tables to decode valid frequency/voltage pairs
>[*] Built-in tables for Banias CPUs 

Can you also try 
[*] ACPI Processor P-states driver

In the same config menu.

Thanks,
Venki
