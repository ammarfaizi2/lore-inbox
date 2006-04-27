Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWD0Tcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWD0Tcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWD0Tcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:32:47 -0400
Received: from mga03.intel.com ([143.182.124.21]:16225 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965069AbWD0Tcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:32:46 -0400
X-IronPort-AV: i="4.04,161,1144047600"; 
   d="scan'208"; a="28708635:sNHT22418431"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 15:32:41 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB64A3FE9@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZqLrm0CstwPjwYTeCfW3rkdEC5VgAAeUBg
From: "Brown, Len" <len.brown@intel.com>
To: "Andi Kleen" <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Cc: <sergio@sergiomb.no-ip.org>, "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Apr 2006 19:32:42.0718 (UTC) FILETIME=[5A46F7E0:01C66A31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>But I guess using GSI/vector internally only would be fine.

The last time I tried to name a variable "gsi" instead of "irq",
Linus launched into a tirade that "GSI" doesn't mean anything to him,
or anybody else that googles it.  On the other hand "IRQ" means
something
to everybody, and if you google it you find all kinds of interesting
interrupt-related things.

My point was that "IRQ" means so many "interrupt related" things to
different people in different contexts, that it is effectively
meaningless.

But Linus was not swayed.

-Len
