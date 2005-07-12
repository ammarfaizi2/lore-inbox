Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVGLEhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVGLEhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVGLEgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:36:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:49314 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262362AbVGLEgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:36:11 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com.suse.lists.linux.kernel>
	<20050712022537.GA26128@infradead.org.suse.lists.linux.kernel>
	<20050711193409.043ecb14.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Jul 2005 06:36:09 +0200
In-Reply-To: <20050711193409.043ecb14.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73ll4c3akm.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Jul 11, 2005 at 08:10:42PM -0500, Tom Zanussi wrote:
> > > 
> > > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> > > logging and buffering capability, which does not currently exist in
> > > the kernel.
> > 
> > While the code is pretty nicely in shape it seems rather pointless to
> > merge until an actual user goes with it.
> 
> Ordinarily I'd agree.  But this is a bit like kprobes - it's a funny thing
> which other kernel features rely upon, but those features are often ad-hoc
> and aren't intended for merging.

Yes, it's a special case because it's useful for custom debugging
hacks. I would be in favour of merging it.

-Andi
