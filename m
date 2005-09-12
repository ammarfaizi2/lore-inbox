Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVILBGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVILBGK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 21:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVILBGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 21:06:10 -0400
Received: from fmr13.intel.com ([192.55.52.67]:55449 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751117AbVILBGJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 21:06:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2/3] Set compatibility flag for 4GB zone on IA64
Date: Sun, 11 Sep 2005 18:05:47 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A8EA0@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2/3] Set compatibility flag for 4GB zone on IA64
Thread-Index: AcW3KAXWXZbejrJ5SLm7jOPflrp7pwADbXVg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <ak@suse.de>, <torvalds@osdl.org>, "Greg Edwards" <edwardsg@sgi.com>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
X-OriginalArrivalTime: 12 Sep 2005 01:05:49.0796 (UTC) FILETIME=[1D520A40:01C5B736]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Luck, Tony wrote:
>> ia64 isn't all that homogeneous.  SGI systems stuff *all* memory
>> into the DMA zone as their I/O devices have no 32-bit limits (just
>> as well really as there is no memory below 4G on an Altix!).
>
>SGI machines support random PCI cards, right?  If so, you 
>cannot presume 
>I/O devices have no 32-bit limits.

No, SGI machines don't support random PCI cards.  The lowest
possible physical address in an Altix is 192GB.  Cards that
can only DMA to addresses below 4G aren't going to be very
useful, are they?

-Tony
