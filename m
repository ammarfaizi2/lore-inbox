Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWEIPUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWEIPUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWEIPUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:20:24 -0400
Received: from ns1.suse.de ([195.135.220.2]:55700 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932520AbWEIPUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:20:23 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
References: <20060509084945.373541000@sous-sol.org>
	<4460AC01.5020503@mbligh.org> <20060509150701.GA14050@infradead.org>
From: Andi Kleen <ak@suse.de>
Date: 09 May 2006 17:20:11 +0200
In-Reply-To: <20060509150701.GA14050@infradead.org>
Message-ID: <p73k68v4444.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, May 09, 2006 at 07:49:37AM -0700, Martin J. Bligh wrote:
> > Congrats on getting this thrashed out. A few comments, most of which are
> > boring style nits, but nonetheless ... will try to take a proper look
> > later.
> > 
> > General comment:
> > 
> > Why is this style used:
> > 
> > HYPERVISOR_foo_bar ?
> > 
> > ie the capitalization of HYPERVISOR. Doesn't seem to fit with the rest
> > of the kernel style.
> 
> It's also wrong.  There's more than one hypervisor and Xen shouldn't just
> grab this namespace.  make it xen_ or xenhv_.

You should reject the recent "hypervisor file system" with the same
argument then.

-Andi
