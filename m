Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWDEBNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWDEBNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWDEBNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:13:43 -0400
Received: from mga03.intel.com ([143.182.124.21]:11111 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751030AbWDEBNm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:13:42 -0400
X-IronPort-AV: i="4.03,165,1141632000"; 
   d="scan'208"; a="19204049:sNHT16203117"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fastboot] [PATCH] kexec on ia64
Date: Wed, 5 Apr 2006 09:13:36 +0800
Message-ID: <08B1877B2880CE42811294894F33AD5C053A85@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] [PATCH] kexec on ia64
Thread-Index: AcZYTd7lUDD23dmsRROc8yUI+VlVigAAA+RQ
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Cc: <ebiederm@xmission.com>, <khalid_aziz@hp.com>,
       <linux-kernel@vger.kernel.org>, <fastboot@lists.osdl.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Apr 2006 01:13:36.0443 (UTC) FILETIME=[2A2578B0:01C6584E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: KAMEZAWA Hiroyuki [mailto:kamezawa.hiroyu@jp.fujitsu.com]
> Sent: 2006年4月5日 9:13
> To: Zou, Nanhai
> Cc: ebiederm@xmission.com; khalid_aziz@hp.com;
> linux-kernel@vger.kernel.org; fastboot@lists.osdl.org;
> linux-ia64@vger.kernel.org
> Subject: Re: [Fastboot] [PATCH] kexec on ia64
> 
> On Wed, 5 Apr 2006 08:36:07 +0800
> "Zou, Nanhai" <nanhai.zou@intel.com> wrote:
> 
> > > -----Original Message-----
> > > From: linux-ia64-owner@vger.kernel.org
> > > [mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Eric W. Biederman
> > > Sent: 2006年4月5日 2:14
> > > To: Khalid Aziz
> > > Cc: LKML; Fastboot mailing list; Linux ia64
> > > Subject: Re: [Fastboot] [PATCH] kexec on ia64
> > >
> > > Khalid Aziz <khalid_aziz@hp.com> writes:
> > >
> > > > Add kexec support on ia64.
> > >
> > > This looks like a starting place but this patch needs some
> > > more work.
> > >
> > Eric,
> > 	Khalid is also merging my ia64 kdump patch posted in
> http://lkml.org/lkml/2006/3/14/46.
> > 	Hopefully those issues you pointed out will be solved once the kdump patch
> is merged.
> >
> Hi, I have a question about kexec/kdump.
> 
> How does kdump know memory layout (of old kernel) now ?
> 
> I'm working for memory hotplug. When memory is hot-added, memory layout
> changes.
> But I think there is no code to manage memory layout information of added memory.
> 
 It reads memory layout from /proc/iomem...,
 If memory is hotpluged, I think we need a reload of kdump.


> Thanks,
> - Kame
