Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWH0SbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWH0SbN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWH0SbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:31:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:62921 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932246AbWH0SbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:31:11 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 9/18] 2.6.17.9 perfmon2 patch for review: kernel-level interface
References: <200608251618_MC3-1-C958-74D1@compuserve.com>
From: Andi Kleen <ak@suse.de>
Date: 27 Aug 2006 20:31:09 +0200
In-Reply-To: <200608251618_MC3-1-C958-74D1@compuserve.com>
Message-ID: <p73ejv2do9e.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

> In-Reply-To: <20060825134704.GA21398@infradead.org>
> 
> On Fri, 25 Aug 2006 14:47:04 +0100, Christoph Hellwig wrote:
> 
> > > This interface is for people writing kprobes who want to do performance
> > > monitoring within their probe code.  There will probably never be any
> > > in-kernel users, just like there are no in-kernel users of kprobes.
> >
> > Wrong argument.  There is a in-tree user of kprobes and I plan to submit
> > a lot more.
> 
> OK.  More than two years after kprobes went into the kernel, a single
> in-kernel user has now appeared in 2.6.18-rc: /net/ipv4/tcp_probe.c

No rules without exceptions. But there has to be a quite good rationale.
kprobes had one.  The mythical perfmon in kernel user doesn't so far.

-Andi
