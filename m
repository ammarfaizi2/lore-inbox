Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUJFCHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUJFCHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUJFCHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:07:41 -0400
Received: from peabody.ximian.com ([130.57.169.10]:54497 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266749AbUJFCHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:07:30 -0400
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive
	(SCSI-libsata, VIA SATA))
From: Robert Love <rml@novell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041006015515.GA28536@havoc.gtf.org>
References: <4136E4660006E2F7@mail-7.tiscali.it>
	 <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com>
	 <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au>
	 <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost>
	 <20041006015515.GA28536@havoc.gtf.org>
Content-Type: text/plain
Date: Tue, 05 Oct 2004 22:07:39 -0400
Message-Id: <1097028459.5062.104.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 21:55 -0400, Jeff Garzik wrote:

> As opposed to fixing drivers???  Please fix the drivers and code first.

No, definitely not, dude.  Fixes for anything--drivers include--is never
superseded by anything else, even the eternal quest for "low latency." 

> > sprinkling cond_resched() hacks all over the kernel.
> 
> cond_resched() is not the only solution.

Indeed.  Most other solutions (fixing algorithms, lowering lock hold
time) have "automatic" benefits with kernel preemption, though, and that
has been what I have always advocated.

	Robert Love


