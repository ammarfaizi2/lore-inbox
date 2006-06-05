Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750890AbWFEKTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWFEKTd (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWFEKTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:19:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63120 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750889AbWFEKTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:19:32 -0400
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060605065856.GA1313@electric-eye.fr.zoreil.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605013223.GD17361@havoc.gtf.org>
	 <20060605065856.GA1313@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 11:32:39 +0100
Message-Id: <1149503559.30554.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-05 am 08:58 +0200, ysgrifennodd Francois Romieu:
> Jeff Garzik <jeff@garzik.org> :
> [...]
> > In general, I'm a bit disappointed at the time it takes new drivers to
> > reach the upstream kernel.  I grant that a lot of vendor drivers are
> > unreadable, unmergable shite...  but on the other side of the coin, I
> > see a lot of decent drivers get stalled simply because they aren't
> > perfect.
> 
> Could you provide an informal list of a few drivers which are currently
> stalled ?

It isn't just drivers. Xen has the same problem. All large code blocks
have this problem. The older policy was to get stuff roughly right,
merge it into a tree then beat on it. Now everyone is blocking anything
that is the slightest imperfect which makes it impossible to add
anything large to the tree because it will *never* be perfect before a
merge and hack session and it will never be perfect in everyones eyes.
Plus of course some people have personal dislikes of Xen, and of various
other projects that get in the way.

Perfection is the enemy of progress and of success. We risk moving back
to the case we got into in 2.4 when merging got so hard that most
vendors shipped kernels bearing no relationship to the "upstream" tree.
Probably worse this time as there is no common "unofficial" tree like
-ac so they will all ship different variants and combinations.

Perfect is the wrong test. In the overall interest of the kernel is the
right test.

Alan

