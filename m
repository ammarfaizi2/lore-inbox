Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUFVTxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUFVTxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUFVTxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:53:06 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:65409 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265678AbUFVTw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:52:29 -0400
Date: Tue, 22 Jun 2004 21:52:19 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: jbglaw@lug-owl.de
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040622195219.GA18743@vana.vc.cvut.cz>
References: <A095D7F069C@vcnet.vc.cvut.cz> <20040622151236.GE20632@lug-owl.de> <20040622173215.GA6300@infradead.org> <20040622184220.GF20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622184220.GF20632@lug-owl.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 08:42:20PM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2004-06-22 18:32:15 +0100, Christoph Hellwig <hch@infradead.org>
> wrote in message <20040622173215.GA6300@infradead.org>:
> > On Tue, Jun 22, 2004 at 05:12:36PM +0200, Jan-Benedict Glaw wrote:
> > > Just merge the vmware modules upstream. Then, such breakage will be
> > > detected early and probably fixed without putting a lot of work into it
> > > (from your point of view).
> > 
> > a) vmware modules themselves aren't under a free license
> 
> That can be changed.

Yes.
 
> > b) even if they were there's not really much interest in modules that can't
> >    work with non-free userspace
> 
> ...as well as this issue. They'd get some (limited but sufficient) free
> maintainence for their software back. See? No technical issues 8^P The
> very same could be said about 4Front's OSS drivers.

I doubt. I emailed with Alan Cox back in 2000 (when VMware 2.0 was to be
released), and he told me that there is no way vmmon & vmnet could find
its way into kernel, regardless of license we'll pick. 

We do not have to go for examples very far - bochs currently does not
provide any networking backend which would work like real network card,
without any restrictions on MAC addresses, host-guest or guest-guest
communications. Patch to get it to work over vmnet's interface was task
for half of one afternoon. Would that change opinion of peoples who accept
only free software? I doubt...

So for now it will probably stay way it is - updates are semi-regullary
distributed from my site, some distros picks them up and repackage for
their customers, and everybody is happy that it more or less works.

						Best regards,
							Petr Vandrovec

