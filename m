Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUJFBzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUJFBzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUJFBzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:55:51 -0400
Received: from havoc.gtf.org ([69.28.190.101]:3031 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266704AbUJFBzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:55:18 -0400
Date: Tue, 5 Oct 2004 21:55:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Robert Love <rml@novell.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA))
Message-ID: <20041006015515.GA28536@havoc.gtf.org>
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097027575.5062.100.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 09:52:55PM -0400, Robert Love wrote:
> On Tue, 2004-10-05 at 21:40 -0400, Jeff Garzik wrote:
> 
> > And with preempt you're still hiding stuff that needs fixing.  And when 
> > it gets fixed, you don't need preempt.
> > 
> > Therefore, preempt is just a hack that hides stuff that wants fixing anyway.
> 
> This actually sounds like the argument for preempt, and against

As opposed to fixing drivers???  Please fix the drivers and code first.


> sprinkling cond_resched() hacks all over the kernel.

cond_resched() is not the only solution.

	Jeff



