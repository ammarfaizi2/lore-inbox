Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTIAXpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 19:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTIAXpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 19:45:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43701
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263338AbTIAXpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 19:45:21 -0400
Date: Tue, 2 Sep 2003 01:46:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org, cgoos@syskonnect.de, mlindner@syskonnect.de,
       linux@syskonnect.de
Subject: Re: 2.4.22pre7aa1: unresolved in sk98lin
Message-ID: <20030901234600.GA11503@dualathlon.random>
References: <20030719013223.GA31330@dualathlon.random> <3F1C763E.78D67BC3@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1C763E.78D67BC3@eyal.emu.id.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 22, 2003 at 09:24:46AM +1000, Eyal Lebedinsky wrote:
> Andrea Arcangeli wrote:
> > 
> > URL:
> > 
> >         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1.bz2
> >         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1/
> > 
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-pre7-aa1/kernel/drivers/net/sk98lin/sk98lin.o
> depmod:         __udivdi3

There are several functions triggering this problem, and it's a mainline
2.4 problem (I don't see anything specific to my tree). 

I'm CCing the authors of the driver, is there a new version or are we the
first triggering it? I can fix it myself but I'd prefer to avoid any
duplication since it's not a one liner.

Thanks,

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
