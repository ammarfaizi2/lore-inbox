Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTKGWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTKGW03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:29 -0500
Received: from ns.suse.de ([195.135.220.2]:35284 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264117AbTKGMrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 07:47:15 -0500
Date: Fri, 7 Nov 2003 13:46:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031107124611.GB506@suse.de>
References: <boe6in$f4q$1@gatekeeper.tmr.com> <Pine.LNX.4.44.0311061143300.1842-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311061143300.1842-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06 2003, Linus Torvalds wrote:
> > I'm not sure what you meant by faster, so don't think I'm disagreeing
> > with you.
> 
> Faster as in "it uses DMA for everything, so you can actually burn at full 
> speed without having to worry about it or sucking up CPU".

And it doesn't do unnecessary data copies either. Not as important as
the DMA issue, but still not completely uninteresting on slower boxes.

-- 
Jens Axboe

