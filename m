Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWGOXey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWGOXey (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWGOXey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 19:34:54 -0400
Received: from tomts35-srv.bellnexxia.net ([209.226.175.109]:54242 "EHLO
	tomts35-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964813AbWGOXey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 19:34:54 -0400
Date: Sat, 15 Jul 2006 16:33:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, stable@kernel.org
Subject: Re: Linux 2.6.16.26
Message-ID: <20060715233333.GA17215@suse.de>
References: <20060715200856.GA15036@kroah.com> <20060715201026.GC15036@kroah.com> <20060715201810.GI2037@1wt.eu> <Pine.LNX.4.64.0607151439020.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607151439020.5623@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 02:40:30PM -0700, Linus Torvalds wrote:
> On Sat, 15 Jul 2006, Willy Tarreau wrote:
> > 
> > You would need to git-reset then git-commit
> 
> Actually, these days we suggest doing
> 
> 	git commit --amend
> 
> instead to change the top commit if you mis-type something or find a 
> problem.
> 
> But, as you point out:
> 
> >					 but it's a little bit dirty
> > and my annoy the users who will have already fetched your tree.
> 
> Indeed. Something that has already been exported should _not_ be amended, 
> because it generates a whole new commit, and people who have already 
> gotten the old one would be unhappy.

Yes, I'll just live with it and remember this for next time.

thanks,

greg k-h
