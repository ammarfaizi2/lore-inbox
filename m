Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268105AbUHTObq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268105AbUHTObq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268110AbUHTObp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:31:45 -0400
Received: from fmr06.intel.com ([134.134.136.7]:16561 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268105AbUHTOa5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:30:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SMP cpu deep sleep
Date: Fri, 20 Aug 2004 07:30:47 -0700
Message-ID: <7F740D512C7C1046AB53446D37200173020B86D9@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMP cpu deep sleep
Thread-Index: AcSGjw548XlcVTjjTA+dSwUh4Q4icgAMa0Hw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Hans Kristian Rosbach" <hk@isphuset.no>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Aug 2004 14:30:48.0299 (UTC) FILETIME=[4931BBB0:01C486C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Hans Kristian Rosbach
>Sent: Friday, August 20, 2004 1:07 AM
>To: linux-kernel@vger.kernel.org
>Subject: SMP cpu deep sleep
>
>While reading through hotplug and speedstep patches
>I came to think of a feature I think might be useful.
>
>In an SMP system there are several cpus, this generates
>extra heat and power consuption even on idle load.
>Is there a way to put all cpus but cpu1 into a kind of
>deep sleep? Cpu1 would have to do all work (including irqs)
>of course.
>
>We have a lot of SMP systems that we host, and they
>are heavily used ~10 hours of the day, the rest they are
>mostly idle. They could run on only 1 cpu during lenghty
>idle periods.
>
>If it is possible to put cpus to a deeper sleep than
>just the simple idle, then the kernel could make use of this.

Most SMP server systems today don't support the C-states beyond C1 (at
least on x86 or x86-64, as far as I know). If your system supports that,
I think it would be nice to do that. 

Jun

>
>It would be a cool feature.
>
>Sincerly
>    Hans K. Rosbach
>

