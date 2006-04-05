Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWDEBfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWDEBfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWDEBfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:35:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:5465 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750954AbWDEBfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:35:07 -0400
X-IronPort-AV: i="4.03,165,1141632000"; 
   d="scan'208"; a="20004434:sNHT622047426"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fastboot] [PATCH] kexec on ia64
Date: Wed, 5 Apr 2006 09:34:56 +0800
Message-ID: <08B1877B2880CE42811294894F33AD5C053A86@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] [PATCH] kexec on ia64
Thread-Index: AcZYT+lBX9ZKdhK0Q/SGPehpmQMyXAAALvmw
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Cc: <ebiederm@xmission.com>, <khalid_aziz@hp.com>,
       <linux-kernel@vger.kernel.org>, <fastboot@lists.osdl.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Apr 2006 01:34:56.0431 (UTC) FILETIME=[251423F0:01C65851]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: KAMEZAWA Hiroyuki [mailto:kamezawa.hiroyu@jp.fujitsu.com]
> Sent: 2006Äê4ÔÂ5ÈÕ 9:28
> To: Zou, Nanhai
> Cc: ebiederm@xmission.com; khalid_aziz@hp.com; linux-kernel@vger.kernel.org;
> fastboot@lists.osdl.org; linux-ia64@vger.kernel.org
> Subject: Re: [Fastboot] [PATCH] kexec on ia64
> 
> On Wed, 5 Apr 2006 09:13:36 +0800
> "Zou, Nanhai" <nanhai.zou@intel.com> wrote:
> > > I'm working for memory hotplug. When memory is hot-added, memory layout
> > > changes.
> > > But I think there is no code to manage memory layout information of added
> memory.
> > >
> >  It reads memory layout from /proc/iomem...,
> >  If memory is hotpluged, I think we need a reload of kdump.
> >
> If /proc/iomem is updated at hotplug event (this is not updated now),
> is there no problem ?
> 
 The crash dumping kernel also needs a reload, because the physical memory list is read and saved at kdump kernel loading time instead of crashing time.

Zou Nan hai
