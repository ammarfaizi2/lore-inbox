Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWBUQFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWBUQFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWBUQFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:05:05 -0500
Received: from postage-due.permabit.com ([66.228.95.230]:1669 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932294AbWBUQFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:05:04 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 hangs, no information on console or serial port
References: <7yirr8hh0z.fsf@questionably-configured.permabit.com>
	<20060221152949.GA31273@kvack.org>
From: David Golombek <daveg@permabit.com>
Date: 21 Feb 2006 11:04:57 -0500
In-Reply-To: <20060221152949.GA31273@kvack.org>
Message-ID: <7ylkw4bsuu.fsf@questionably-configured.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:
> On Tue, Feb 21, 2006 at 10:23:56AM -0500, David Golombek wrote:
> > Any suggestions as to how we might debug this or possible causes would
> > be greatly appreciated.
> 
> Have you tried turning on the NMI watchdog (nmi_watchdog=1)?  It
> should be able to kick the machine out of the locked state, as these
> symptoms would hint at a spinlock deadlock with interrupts disabled.
> Also, try to reproduce on the latest 2.4.33pre.  That said, for an
> io intensive workload like you're running, 2.6 is much better,
> especially for systems using highmem.

I'll enable nmi_watchdog as soon as we can bring the machine down,
thanks for the excellent suggestion. I'd entirely forgotten about the
watchdog.  I'll try to switch to 2.4.33pre out as soon as poosible, it
certainly has several fixes we've been waiting for.  2.6 is still a
ways off, lots of qualification work to do.

Thanks,
Dave

