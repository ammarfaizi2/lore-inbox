Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264941AbUFAJDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUFAJDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUFAJDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:03:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:16256 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264941AbUFAJDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:03:45 -0400
Date: Tue, 1 Jun 2004 10:10:32 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406010910.i519AWsm000213@81-2-122-30.bradfords.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Michael Brennan <mbrennan@ezrs.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040601085456.GJ2093@holomorphy.com>
References: <40BB88B5.8080300@ezrs.com>
 <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk>
 <40BBB5F7.1010407@yahoo.com.au>
 <200406010834.i518Y1cT000414@81-2-122-30.bradfords.org.uk>
 <20040601083206.GI2093@holomorphy.com>
 <200406010850.i518o8PD000134@81-2-122-30.bradfords.org.uk>
 <20040601085456.GJ2093@holomorphy.com>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from William Lee Irwin III <wli@holomorphy.com>:
> Quote from William Lee Irwin III <wli@holomorphy.com>:
> >> So you can move userspace pages out of ZONE_DMA as-needed.
> 
> On Tue, Jun 01, 2004 at 09:50:08AM +0100, John Bradford wrote:
> > But how does that improve performance before untouched RAM, (496788 in this
> > example), is exhausted?
> > In normal use, (almost always CPU bound), I've honestly never noticed any
> > performance gain from having swap configured.  I must admit I haven't put
> > a lot of effort recently in to looking at this, but I have never been able
> > to reproduce these 'swap increases performance even with untouched RAM'
> > claims.
> 
> Because ZONE_DMA, the lower 16MB is not all of RAM.

Ah, OK, this isn't really my area of expertise so maybe this is a stupid, (for
LKML), question, but can we only migrate data from low RAM via swap!?

Also, surely this is only relevant to X86 architectures?

John.
