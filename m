Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUIIS3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUIIS3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUIIS1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:27:36 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:45441 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266569AbUIIR47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:56:59 -0400
Date: Thu, 9 Sep 2004 13:56:23 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040909175622.GA32489@yoda.timesys>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908134903.A31498@infradead.org> <20040908130552.GC20132@elte.hu> <20040908141217.A31690@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908141217.A31690@infradead.org>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:12:17PM +0100, Christoph Hellwig wrote:
> On Wed, Sep 08, 2004 at 03:05:52PM +0200, Ingo Molnar wrote:
> > is there any architecture that cannot make use of kernel/hardirq.c _at
> > all_?
> 
> s390 doesn't need it at all because it doesn't have the concept of hardirqs.
> 
> At least arm{,26}, m68k{,nommu} and parisc and sparc{,64} use extremly
> different models for irq handling

They're not irreparably different, though (at least, not all of
them); we had generic IRQ code (with threads) running in our 2.4
kernel on arm and sparc64.

-Scott
