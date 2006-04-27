Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWD0UhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWD0UhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWD0UhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:37:01 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:6415 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1751631AbWD0Ug7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:36:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 15:36:50 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BA3@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZqLrm0CstwPjwYTeCfW3rkdEC5VgAAeUBgAAIwilA=
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brown, Len" <len.brown@intel.com>, "Andi Kleen" <ak@suse.de>
Cc: <sergio@sergiomb.no-ip.org>, "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Apr 2006 20:36:51.0156 (UTC) FILETIME=[50200140:01C66A3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >But I guess using GSI/vector internally only would be fine.
> 
> The last time I tried to name a variable "gsi" instead of "irq",
> Linus launched into a tirade that "GSI" doesn't mean anything to him,
> or anybody else that googles it.  On the other hand "IRQ" means
> something
> to everybody, and if you google it you find all kinds of interesting
> interrupt-related things.
> 
> My point was that "IRQ" means so many "interrupt related" things to
> different people in different contexts, that it is effectively
> meaningless.
> 
> But Linus was not swayed.
> 

Oh Len, let's call this thing IRQ why not ;) I kind of agree that this
is more popular and well-known term, like an old trade mark. I just see
all those layers of code right now to map those to GSIs, pins, whatever
it is, that can be replaced with... well, much smaller layers of code :)
and maybe less "assumpti-ous" too.

--Natalie 
