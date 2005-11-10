Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVKJAZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVKJAZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVKJAZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:25:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38797 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751109AbVKJAZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:25:24 -0500
Date: Wed, 9 Nov 2005 16:25:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: James.Bottomley@steeleye.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       axboe@suse.de, shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
Message-Id: <20051109162515.39608d08.akpm@osdl.org>
In-Reply-To: <200511101116.47034.kernel@kolivas.org>
References: <20051109133558.513facef.akpm@osdl.org>
	<1131575124.8541.9.camel@mulgrave>
	<20051109150141.0bcbf9e3.akpm@osdl.org>
	<200511101116.47034.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> On Thu, 10 Nov 2005 10:01 am, Andrew Morton wrote:
> > James Bottomley <James.Bottomley@SteelEye.com> wrote:
> > > it's my contributors who drop me in it
> > > by leaving their patch sets until you declare a kernel, dumping the
> > > integration testing on me in whatever time window is left.
> >
> > Yes, I think I'm noticing an uptick in patches as soon as a kernel is
> > released.
> >
> > It's a bit irritating, and is unexpected (here, at least).  I guess people
> > like to hold onto their work for as long as possible so when they release
> > it, it's in the best possible shape.
> 
> I suspect part of that is the concern about whether the code will merge with 
> whatever -mm looks like next. Of course you already do ludicrous amounts of 
> merging, but sometimes you'll just throw it back and say "too many rejects".

Well of course that's not a concern for people who work against the git
trees - scsi/usb/ia64/whatever developers.

But yes, sometimes people's work does clash just too much with things which
are already in subsystem trees or in -mm.  Fortunately it's relatively
rare, and I do think it's best to ask people to develop against latest
-linus rather than against a crazy -mmoving target.

Especially as lots of people are stuck using git, rather than high-tech
patch management technologies ;)


Actually, I disagree with you - it's at 2.6.x release-time that all trees,
including -mm are at their most divergent.  Presumably these developers are
working against the relevant subsystem git tree, and hence can merge into
the subsystem maintainer at any time.
