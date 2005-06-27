Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVF0HYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVF0HYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVF0HYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:24:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64726 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261474AbVF0HYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:24:02 -0400
Date: Mon, 27 Jun 2005 09:24:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Mahoney <jeffm@suse.de>,
       penberg@gmail.com, reiser@namesys.com, ak@suse.de, flx@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627072449.GF19550@suse.de>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de> <20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de> <1119717967.9392.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119717967.9392.2.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25 2005, Pekka Enberg wrote:
> Hi,
> 
> On Thu, 2005-06-23 at 21:32 +0200, Jens Axboe wrote:
> > then it's impossible to know which one it is without the identical
> > source at hand.
> 
> In which case, debugging is risky IMO (the source code could have
> changed a lot).

That's not an argument, there are plenty of cases where knowing which
BUG() triggered provides ample clue to at least start thinking about
possible issues.

> On Thu, 2005-06-23 at 21:32 +0200, Jens Axboe wrote:
> > That said, I don't like the reiser name-number style. If you must do
> > something like this, mark responsibility by using a named identifier
> > covering the layer in question instead.
> > 
> >         assert("trace_hash-89", is_hashed(foo) != 0);
> 
> A human readable message would be nicer. For example, "foo was hashed".

Indeed.

-- 
Jens Axboe

