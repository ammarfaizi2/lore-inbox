Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbUJ1Cl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbUJ1Cl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 22:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUJ1Cl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 22:41:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:45242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262722AbUJ1ClV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 22:41:21 -0400
Date: Wed, 27 Oct 2004 19:35:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@novell.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.61.0410280314490.877@scrub.home>
Message-ID: <Pine.LNX.4.58.0410271932150.28839@ppc970.osdl.org>
References: <1098707342.7355.44.camel@localhost.localdomain>
 <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com>
 <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com>
 <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com>
 <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com>
 <Pine.LNX.4.61.0410280314490.877@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Oct 2004, Roman Zippel wrote:
> 
> Actually the Commit numbers are far more interesting and here you have 
> difference of 56% you haven't explained.

It's because CVS cannot handle what BK does. So when you do a BK merge, 
there's no way in hell that will be a CVS merge, and instead it ends up 
being one big commit of the branch.

Merges happen pretty often, so these "big commits" aren't _that_ big
(certainly nowhere near as big as a CVS banch merge tends to be - if only
simply because nobody uses CVS for "small branches", the pain isn't worth
it). 

Face it. BK is just better than CVS. It's not a 1:1 mapping.

		Linus
