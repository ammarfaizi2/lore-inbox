Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUCMAXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUCMAXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:23:48 -0500
Received: from fmr06.intel.com ([134.134.136.7]:45290 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262713AbUCMAXn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:23:43 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: RE[PATCH]2.6.4-rc3 MSI Support for IA64
Date: Fri, 12 Mar 2004 16:22:00 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058151@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE[PATCH]2.6.4-rc3 MSI Support for IA64
Thread-Index: AcQIiqOOwsuywEBTRCmro2hS8qsDeAABavCw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <davidm@hpl.hp.com>, "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "long" <tlnguyen@snoqualmie.dp.intel.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <grep@kroah.com>, <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 13 Mar 2004 00:22:00.0722 (UTC) FILETIME=[33E62F20:01C40891]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, David Mosberger wrote:

>>>>> On Fri, 12 Mar 2004 18:26:39 -0500 (EST), Zwane Mwaikambo <zwane@linuxpower.ca> said:

>  Zwane> I wonder if we could consolidate these vector allocators as
>  Zwane> assign_irq_vector(AUTO_ASSIGN) has the same semantics as
>  Zwane> ia64_alloc_vector() and the one for i386 is also almost the
>  Zwane> same as its MSI ilk.

> Agreed.  I don't see any reason why ia64_alloc_vector() and
> assign_irq_vector() couldn't or shouldn't be one and the same thing
> (and assign_irq_vector() is a fine name).

Agree. Thanks!

> Tom, if you want to send me a patch that converts the existing uses of
> ia64_alloc_vector() to assign_irq_vector(), I'd be happy to apply
> (assuming it's clean etc., as usual).

Thanks! We'll do. I will work with Tony and Jun to consolidate i386/IA64 vector 
allocators to ensure it is clean.

Thanks,
Long
