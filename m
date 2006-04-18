Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWDRRnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWDRRnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWDRRnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:43:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:24967 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932220AbWDRRnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:43:15 -0400
Date: Tue, 18 Apr 2006 10:42:05 -0700
From: Greg KH <gregkh@suse.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Fixes in the -stable tree, but not in mainline
Message-ID: <20060418174205.GA684@suse.de>
References: <20060417212946.GA3118@kroah.com> <20060418160610.GA10933@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418160610.GA10933@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 12:06:10PM -0400, Theodore Ts'o wrote:
> On Mon, Apr 17, 2006 at 02:29:46PM -0700, Greg KH wrote:
> > Here are 5 patches that are in the -stable tree, yet not currently fixed
> > in your mainline tree.  One of them is a security fix, so it probably
> > would be a good idea to get it into there :)
> 
> I thought one of the requirements for accepting a patch into -stable
> was that it was already in mainline.  Was this a change in policy that
> I missed, or just an oversight when we vetted these patches?
> 
> Not that I have anything against these patches, just curious in the
> future if we should NACK patches proposed for -stable if we notice
> that they aren't yet in mainline.

Sometimes some of these patches don't make it into Linus's tree because
they get lost in the shuffle (like the Kconfig one), or because they
were security issues that hit -stable first (like another one in there).

Either way, yes, the rule is that it should be in mainline, or in the
pipe to get into mainline (as was the 5 in this patchset.)  I just
wanted to make sure they made it into there, and didn't get lost.

thanks,

greg k-h
