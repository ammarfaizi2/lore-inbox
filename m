Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbUKQPIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbUKQPIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKQPIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:08:45 -0500
Received: from fmr14.intel.com ([192.55.52.68]:29630 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262241AbUKQPIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:08:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] prefer TSC over PM Timer
Date: Wed, 17 Nov 2004 07:08:27 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60035C6850@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] prefer TSC over PM Timer
Thread-Index: AcTMsIMhf01sgb1jQdefWEkVtLSi8gABbkAg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <dtor_core@ameritech.net>,
       "dean gaudet" <dean-list-linux-kernel@arctic.org>
Cc: "john stultz" <johnstul@us.ibm.com>, "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Nov 2004 15:08:29.0587 (UTC) FILETIME=[4BCAA630:01C4CCB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
>Sent: Wednesday, November 17, 2004 6:20 AM
>To: dean gaudet
>Cc: Pallipadi, Venkatesh; john stultz; lkml
>Subject: Re: [patch] prefer TSC over PM Timer
>
>On Tue, 16 Nov 2004 17:50:42 -0800 (PST), dean gaudet
><dean-list-linux-kernel@arctic.org> wrote:
>> on a tangent... has the local apic timer ever been 
>considered?  it's fixed
>> rate, and my measurements show it in the same performance 
>ballpark as TSC.
>> 
>
>At least Dell laptops will die horrible death if you enable lapic,
>probably others.
>

Hmm... And local APIC timer comes with its own set of problems 
http://bugme.osdl.org/show_bug.cgi?id=2560

While in C3, we don't get local APIC timer interrupts.

Thanks,
Venki
