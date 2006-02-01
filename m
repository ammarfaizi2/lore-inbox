Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWBASNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWBASNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWBASNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:13:12 -0500
Received: from fmr21.intel.com ([143.183.121.13]:447 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932448AbWBASNK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:13:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Wed, 1 Feb 2006 13:11:36 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005E907CA@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Thread-Index: AcYm4NOTyrhNWOQ4RmmeF+1vwEmKDgAeYV+w
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Joerg Sommrey" <jo@sommrey.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <arjan@infradead.org>, "Tony Lindgren" <tony@atomide.com>
X-OriginalArrivalTime: 01 Feb 2006 18:11:38.0842 (UTC) FILETIME=[F211A3A0:01C6275A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>>  This patch can also be found at
>>  http://www.sommrey.de/amd76x_pm/amd76x_pm-2.6.15-4.patch
>> 
>>  In this version more locking was added to make sure all or 
>>  no CPU enter C3 mode.
>> 
>>  Signed-off-by: Joerg Sommrey <jo@sommrey.de>
>
>Thanks.  I'll merge this into -mm and shall plague the ACPI 
>guys with it. 
>They have said discouraging things about board-specific drivers in the
>past.  We shall see.

Linux/ACPI has had generic supported SMP deep (> C1) C-states
for a few months now and AFAIK it is working fine.
Why is a platform specific driver needed for these boards?

-Len
