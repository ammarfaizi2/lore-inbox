Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVAYQ64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVAYQ64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVAYQ6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:58:49 -0500
Received: from nevyn.them.org ([66.93.172.17]:25794 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262011AbVAYQ6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:58:30 -0500
Date: Tue, 25 Jan 2005 11:58:07 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: CVSps@dm.cobite.com, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: kernel CVS troubles with cvsps
Message-ID: <20050125165807.GA20828@nevyn.them.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>, CVSps@dm.cobite.com,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruen@suse.de>
References: <20050125164203.GY7587@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125164203.GY7587@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 05:42:03PM +0100, Andrea Arcangeli wrote:
> Any help is appreciated. I'm just starting to look more seriously into
> this since I've some tools that depends on the cvsps to work and kernel
> CVS is the only fully coherent linearized source of info in open format
> (rest is either a priorietary format or unusable because out of
> synchrony because not linearized).  Until now I hoped that by waiting it
> would automatically fixup, but it didn't yet ;).

FYI, I haven't tried using cvsps on the kernel CVS, but I used to use it on
GCC - and it fell down like this on a constant basis.

You might want to take a look at 'xcvs', by Jun Sun.  It's much more
reliable and does everything I used to use cvsps for.  And generally
faster too.

-- 
Daniel Jacobowitz
