Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161433AbWJZQeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161433AbWJZQeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWJZQeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:34:10 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:4746 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161433AbWJZQeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:34:09 -0400
X-BigFish: VP
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Hardware Problem - Asus A8N-VM CSM
Date: Thu, 26 Oct 2006 11:33:34 -0500
Message-ID: <1449F58C868D8D4E9C72945771150BDF153767@SAUSEXMB1.amd.com>
In-Reply-To: <4540C76F.9050403@perkel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hardware Problem - Asus A8N-VM CSM
Thread-Index: Acb5DDNt9ctZU4K3REOOvu001g8NlgAD8xhw
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Marc Perkel" <marc@perkel.com>, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 26 Oct 2006 16:33:35.0021 (UTC)
 FILETIME=[7B550DD0:01C6F91C]
X-WSS-ID: 695E3CD50Z4593284-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem. 2 out of the 4 sees all 4 gigs of ram. The other 2 see 
> > only 2.8 gigs of ram. And it's hardware related because in the bios 
> > setup the ones that show 2.8 show it in the bios.
> >
> > The motherboards were not prchased at the same time. All have 
> > different brands of ram. And the processors are different. 
> > The 2 that don't see all the ram are the newest ones.
> >
> > I tried swapping ram between one that saw 2.8 gigs and one 
> > that saw 4 gigs and the problem stays with the motherboard.
> > I haven't yet swapped out the processors.
> >
> > So - I'm a little stumped. Can someone point me in the 
> > right direction?

Usually, missing memory comes from the PCI I/O hole, or the
IOMMU/AGP/framebuffer overlays.  Does your BIOS have an
options for creating a memory hole or hoisting memory?  If
so, are the settings between the 4G machines different from
the 2.8G machines?

Also, do you have an IOMMU aperture enabled and if so, how
large?

Are there any hardware differences between the systems, like
different AGP or PCI graphics cards?

> Answering my own question perhaps. Could it be related to 
> whether or not the processor is a "revision e" chip?

Possibly, but I'd expect the RevE parts to see more DRAM than
the earlier parts.

-Mark Langsdorf
AMD, Inc.


