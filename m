Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVLVMGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVLVMGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVLVMGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:06:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3487 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964832AbVLVMGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:06:02 -0500
Date: Thu, 22 Dec 2005 12:05:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: quick overview of the perfmon2 interface
Message-ID: <20051222120558.GA31303@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@hpl.hp.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
	perfctr-devel@lists.sourceforge.net
References: <20051219113140.GC2690@frankl.hpl.hp.com> <20051220025156.a86b418f.akpm@osdl.org> <20051222115632.GA8773@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222115632.GA8773@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 03:56:32AM -0800, Stephane Eranian wrote:
> reason:
> 	- allow support of existing kernel profiling infratructures such as
> 	  Oprofile or VTUNE (the VTUNE driver is open-source)

last time I checked it was available in source, but not under an open-source
license.  has this changed?  In either case intel should contribute to the
kernel profiling infrastructure instead of doing their own thing.  Supporting
people to do their own private variant is always a bad thing.

> Let's take an example on Itanium. Take a user running a commercial distro
> based on 2.6. This user is given early access to a Montecito machine.

That scenario is totally uninteresting for kernel development.  we want
to encourage people to use upstream kernels, and not the bastardized vendor
crap.

I think you're adding totally pointless complexity everywhere for such
scenarious because HP apparently cares for such vendor mess.  Maybe you
should concentrate on what's best for upstream kernel development.  And
the most important thing is to reduce complexity by at least one magnitude.

