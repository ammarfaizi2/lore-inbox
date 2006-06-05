Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750953AbWFEK5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWFEK5A (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWFEK5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:57:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51243 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750946AbWFEK47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:56:59 -0400
Date: Mon, 5 Jun 2006 12:59:26 +0200
From: Jens Axboe <axboe@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: header cleanup and install
Message-ID: <20060605105925.GD4400@suse.de>
References: <20060604135011.decdc7c9.akpm@osdl.org> <1149456793.30024.21.camel@pmac.infradead.org> <20060605105240.GB4400@suse.de> <1149504858.30024.68.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149504858.30024.68.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05 2006, David Woodhouse wrote:
> On Mon, 2006-06-05 at 12:52 +0200, Jens Axboe wrote:
> > I guess the color -> colour transformation is clouding the
> > inclusion :-)
> 
> Heh. Well, mostly I've just _removed_ the references colo{u,}r, since
> callers shouldn't be poking at it anyway in general. We have
> rb_set_black() and rb_set_red() now, but even those are only really for
> the rbtree code itself to be using.

Yeah I'm just kidding, I just noticed that your British fingers could
not leave the "color" alone! The patches are fine with me, rb usage is
quite wide spread and shrinking the nodes is definitely a good thing.

-- 
Jens Axboe

