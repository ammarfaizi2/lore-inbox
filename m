Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTLWTmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTLWTmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:42:11 -0500
Received: from havoc.gtf.org ([63.247.75.124]:18382 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262714AbTLWTmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:42:09 -0500
Date: Tue, 23 Dec 2003 14:42:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Rob Love <rml@ximian.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223194209.GA26278@gtf.org>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com> <20031223191634.A8914@infradead.org> <1072207183.6015.19.camel@fur> <20031223192226.A10239@infradead.org> <1072207555.6015.22.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072207555.6015.22.camel@fur>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 02:25:56PM -0500, Rob Love wrote:
> On Tue, 2003-12-23 at 14:22, Christoph Hellwig wrote:
> 
> > Well, it's not just for /dev/random but also for all in-kernel cosumers
> > of random numbers, so doing this as a sysctl makes quite a lot of sense.
> 
> And /dev/random is the user-space abstraction representing the random
> number generator... 

Not precisely.  If your userspace program can obtain random numbers in
some other way, it should...  /dev/random shouldn't be considered as the
canonical source for random bits for the entire machine.

	Jeff



