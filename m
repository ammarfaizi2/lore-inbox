Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbTLaEzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbTLaEzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:55:31 -0500
Received: from dp.samba.org ([66.70.73.150]:40617 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266114AbTLaEza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:55:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, Paul Jackson <pj@sgi.com>, anton@samba.org,
       linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 1/2] Make for_each_cpu() Iterator More Friendly 
In-reply-to: Your message of "Wed, 31 Dec 2003 01:54:10 -0000."
             <20031231015410.A12194@infradead.org> 
Date: Wed, 31 Dec 2003 15:53:36 +1100
Message-Id: <20031231045528.4E0C22C0CA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031231015410.A12194@infradead.org> you write:
> On Wed, Dec 31, 2003 at 12:26:34PM +1100, Rusty Russell wrote:
> > Please apply.  Applies against 2.6.0-mm2 and 2.6.0-bk3.  Yay!
> > 
> > Anton: breaks PPC64, as it needs cpu_possible_mask, but fix is already
> > in Ameslab tree.
> 
> So what about including the fix in the patch?  I don't think a fix in some
> obscure tree is a good excuse to break an architecture in a stable series..

Because (1) they've done it already, in anticipation of this change,
and tested it in their tree, and (2) it's a non-trivial patch, as they
don't have a cpu_possible mask concept at all.

FYI, the Ameslab tree is the main PPC64 public tree.

Now, do you need me to explain anything else?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
