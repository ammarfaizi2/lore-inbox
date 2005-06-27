Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVF0Ova@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVF0Ova (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVF0Osc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:48:32 -0400
Received: from mx1.suse.de ([195.135.220.2]:52665 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262039AbVF0MiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:38:23 -0400
Date: Mon, 27 Jun 2005 14:38:22 +0200
From: Andi Kleen <ak@suse.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andi Kleen <ak@suse.de>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Mahoney <jeffm@suse.de>,
       penberg@gmail.com, reiser@namesys.com, flx@namesys.com, zam@namesys.com,
       vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, joern@wohnheim.fh-wedel.de
Subject: Re: [PATCH] verbose BUG_ON reporting
Message-ID: <20050627123821.GE14251@wotan.suse.de>
References: <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de> <20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de> <1119717967.9392.2.camel@localhost> <20050627072449.GF19550@suse.de> <20050627072832.GA14251@wotan.suse.de> <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI> <20050627082046.GC14251@wotan.suse.de> <Pine.LNX.4.58.0506271525240.3200@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506271525240.3200@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:27:50PM +0300, Pekka J Enberg wrote:
> On Mon, 27 Jun 2005, Andi Kleen wrote:
> > It won't work for me because it'll bloat the kernel .text
> > considerable. There is a reason why BUG is implemented
> > like it is. Compare it.
> 
> The assertion codes bloat the kernel all the same. So how about this 
> instead?

It's still useless - it is too bloated to turn on by default
and then if you need it you still won't have it.  And when you
explicitely turn it on then you likely don't need it because
you control the source.

-Andi
