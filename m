Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbVIIBrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbVIIBrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbVIIBrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:47:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20366 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965232AbVIIBrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:47:33 -0400
Date: Thu, 8 Sep 2005 18:46:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
Message-Id: <20050908184659.6aa5a136.akpm@osdl.org>
In-Reply-To: <432073610200007800024489@emea1-mh.id2.novell.com>
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
	<20050908151624.GA11067@infradead.org>
	<432073610200007800024489@emea1-mh.id2.novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> >>> Christoph Hellwig <hch@infradead.org> 08.09.05 17:16:24 >>>
> >On Thu, Sep 08, 2005 at 05:03:58PM +0200, Jan Beulich wrote:
> >> (Note: Patch also attached because the inline version is certain to
> get
> >> line wrapped.)

Suggest you get a new email setup.

> ...
> That's funny - on one hand I'm asked to not submit huge patches (not by
> you, but by others), but on the other hand not having the consuming code
> in the same patch as the providing one is now deemed to be a problem.

Nope.

Each patch should do a single logical thing.  That doesn't mean that we
want to trickle patches in across a period of months.  It means that a
bunch of spearate (and separately reviewed) patches can all go in at the
same time.

So the split-it-up request is for reviewing (and debugging) convenience
only.

