Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWEIQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWEIQaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWEIQap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:30:45 -0400
Received: from palrel11.hp.com ([156.153.255.246]:9103 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1750806AbWEIQah convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:30:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH 03/35] Add Xen interface header files
Date: Tue, 9 May 2006 09:30:35 -0700
Message-ID: <516F50407E01324991DD6D07B0531AD5B24A10@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 03/35] Add Xen interface header files
Thread-Index: AcZzg5ygH5ZZwXhrSf+AgkwAhCdQYgAAaROg
From: "Magenheimer, Dan (HP Labs Fort Collins)" <dan.magenheimer@hp.com>
To: "Daniel Walker" <dwalker@mvista.com>, "Chris Wright" <chrisw@sous-sol.org>
Cc: <virtualization@lists.osdl.org>, <xen-devel@lists.xensource.com>,
       <linux-kernel@vger.kernel.org>, "Ian Pratt" <ian.pratt@xensource.com>
X-OriginalArrivalTime: 09 May 2006 16:30:36.0360 (UTC) FILETIME=[E69E0C80:01C67385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  include/xen/interface/arch-x86_32.h   |  197 +++++++++++++++
> >  include/xen/interface/event_channel.h |  205 +++++++++++++++
> >  include/xen/interface/features.h      |   53 ++++
> >  include/xen/interface/grant_table.h   |  311 
> +++++++++++++++++++++++
> >  include/xen/interface/io/blkif.h      |   85 ++++++
> 
> 
> Shouldn't these be under asm-i386 , or are they used by other
> architecture ? 

The latter.  Xen also runs on ia64 (and soon ppc) and
many Xen header files are arch-independent.

Dan

