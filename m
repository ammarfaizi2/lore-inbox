Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268165AbUIKPeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268165AbUIKPeI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUIKPeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:34:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46811 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268165AbUIKPeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:34:04 -0400
Date: Sat, 11 Sep 2004 08:32:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: device driver for the SGI system clock, mmtimer
In-Reply-To: <20040911115002.B1053@infradead.org>
Message-ID: <Pine.LNX.4.58.0409110831530.15088@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0409082058140.28678@schroedinger.engr.sgi.com>
 <20040908210537.585120c1.akpm@osdl.org> <Pine.LNX.4.58.0409082210230.29080@schroedinger.engr.sgi.com>
 <200409082343.21330.jbarnes@engr.sgi.com> <Pine.LNX.4.58.0409101251400.9101@schroedinger.engr.sgi.com>
 <20040911115002.B1053@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004, Christoph Hellwig wrote:

> On Fri, Sep 10, 2004 at 12:54:30PM -0700, Christoph Lameter wrote:
> > On Wed, 8 Sep 2004, Jesse Barnes wrote:
> > > We may as well kill anything under MMTIMER_INTERRUPT_SUPPORT.  IIRC, people
> > > use SHub timer interrupts, but not via this driver.  If you want to fix it,
> > > that's ok too, but you can kill the #ifdef in that case also.
> >
> > Here is the driver with the interrupt support "killed". Hope this is
> > enough to get it into the kernel, Andrew? I did not get any other
> > feedback:
>
> please at least kill all the userland gunk from mmtmer.h
>
Its just a test program.... and mmtimer.h is already quite tiny.

