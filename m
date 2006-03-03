Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWCCJRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWCCJRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCCJRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:17:05 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:26629 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1750831AbWCCJRD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:17:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Fri, 3 Mar 2006 09:16:55 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393C2A6@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY99Ivg52RYxdwzQe+CKKzPavN3ZwArNTzg
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>, "Andi Kleen" <ak@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>, "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Mar 02 2006, Andi Kleen wrote:
> > On Thursday 02 March 2006 12:10, Jens Axboe wrote:
> > 
> > > I'm waiting for Andi to render an opinion on the problem. 
> It should have
> > > no corruption implications, the PIO path will handle 
> arbitrarily large
> > > requests. I'm assuming the mapped sg table is correct, 
> just odd looking
> > > for some reason.
> > 
> > I was waiting for feedback if iommu=nomerge changes 
> anything. With that option
> > the IOMMU code will never touch the layout of the sg list, 
> just rewrite
> > ->dma_address
> 
> Andy already reported that it didn't change anything. The 
> output doesn't
> looked merged anyways in most of the cases, it's the offsetting that
> looks odd.
> 

Indeed I did: <http://lkml.org/lkml/2006/3/1/109>

-- 
Andy, BlueArc Engineering
 
