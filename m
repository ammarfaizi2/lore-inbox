Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUBETcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUBETcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:32:16 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:57740 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S266810AbUBETcG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:32:06 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Thu, 5 Feb 2004 11:31:32 -0800
Message-ID: <A28EFEDC5416054BA1026D892753E9AF04273625@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPsGeNAOrnQvIH2SSiJ8jwDyW0WmAAAzTUg
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Greg KH" <greg@kroah.com>, "King, Steven R" <steven.r.king@intel.com>,
       <linux-kernel@vger.kernel.org>
Cc: <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Feb 2004 19:31:51.0558 (UTC) FILETIME=[B45B9260:01C3EC1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>linux kernel
>
>On Thu, Feb 05, 2004 at 10:27:54AM -0800, King, Steven R wrote:
>> Hi Greg,
>> What exactly is wrong with spinlock?  Far as I know, it's been
working
>> bug-free on a variety of platforms for quite some time now.  The
other
>> abstractions such as atomic_t are for platform portability.
>
>Again, compare them to the current kernel spinlocks and try to realize
>why your implementation of spinlock_irqsave() will not work on all
>platforms.

Humm... think the spin_lock macros used are the _ones_ that is defined
in the linux kernel, the other version (cl_spin_lock) is just a
wrapper... there is some precedence in the current linux code base that
does the same kind of wrapper thingies... , but iam sure no one is *so*
excited about *that* code anyway, so I will keep shut!


>
>Come on, just use the kernel versions, there is no need to reinvent the
>wheel all of the time, it just wastes everyones time (including
mine...)
>

