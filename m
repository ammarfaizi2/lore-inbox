Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVCCSNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVCCSNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVCCSMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:12:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:64953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262562AbVCCSLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:11:40 -0500
Date: Thu, 3 Mar 2005 10:11:22 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303181122.GB12103@kroah.com>
References: <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <422751C1.7030607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422751C1.7030607@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 01:04:49PM -0500, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >In fact, if somebody maintained that kind of tree, especially in BK, it 
> >would be trivial for me to just pull from it every once in a while (like 
> >ever _day_ if necessary). But for that to work, then that tree would have 
> >to be about so _obviously_ not wild patches that it's a no-brainer.
> >
> >So what's the problem with this approach? It would seem to make everybody
> >happy: it would reduce my load, it would give people the alternate "2.6.x
> >base kernel plus fixes only" parallell track, and it would _not_ have the 
> >testability issue (because I think a lot of people would be happy to test 
> >that tree, and if it was always based on the last 2.6.x release, there 
> >would be no issues.
> 
> The only problem I see with this -- and its a minor problem -- is that 
> some patches that belong in the 2.6.X.Y tree go straight to you/Andrew, 
> rather than to $sucker.
> 
> It's perfectly workable from a BK standpoint to do
> 
> 	-> linux-2.6 commit
> 	-> cpcset into linux-2.6.X.Y [see Documentation/BK-usage/cpcset]
> 	-> pull from linux-2.6.X.Y into linux-2.6 [dups cset, but no
> 	   real code change]

That's fine with me to do.  As long as someone points out to $sucker
that such a patch should go into 2.6.x.y.

thanks,

greg k-h
