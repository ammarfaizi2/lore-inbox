Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUCZWAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUCZWAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:00:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:53948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261358AbUCZV6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:58:21 -0500
Date: Fri, 26 Mar 2004 14:00:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.5-rc2-mm4
Message-Id: <20040326140027.044c96a3.akpm@osdl.org>
In-Reply-To: <20040326214007.A10869@infradead.org>
References: <20040326131816.33952d92.akpm@osdl.org>
	<20040326132212.14bac327.akpm@osdl.org>
	<20040326214007.A10869@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Mar 26, 2004 at 01:22:12PM -0800, Andrew Morton wrote:
> > +si_band-is-long.patch
> > 
> >  Make the siginfo si_band field unsigned long.
> 
> Do we still need __ARCH_SI_BAND_T with this one?

Nope, I'll kill that, thanks.

> > +dont-show-cdroms-in-proc-partitions.patch
> > 
> >  Suppress cdroms in /proc/partitions
> 
> What's this patch trying to archive?  IDE cdroms are partitionable in
> 2.5..

Jens?
