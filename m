Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVBUSeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVBUSeM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBUSeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:34:12 -0500
Received: from adsl-64-172-240-129.dsl.sndg02.pacbell.net ([64.172.240.129]:12448
	"EHLO mail.davidb.org") by vger.kernel.org with ESMTP
	id S262070AbVBUSeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:34:01 -0500
Date: Mon, 21 Feb 2005 10:33:58 -0800
From: David Brown <darcs@davidb.org>
To: darcs-users@darcs.net, linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050221183358.GA5476@old.davidb.org>
References: <20050214020802.GA3047@bitmover.com> <845b6e8705021803533ba8cc34@mail.gmail.com> <20050218125057.GE2071@opteron.random> <200502190410.31960.pmcfarland@downeast.net> <20050219164213.GB7247@opteron.random> <20050219171457.GA20285@abridgegame.org> <20050219175348.GE7247@opteron.random> <20050221124153.GB27294@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050221124153.GB27294@abridgegame.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 07:41:54AM -0500, David Roundy wrote:

> The catch is that then we'd have to implement a smart server to keep users
> from having to download the entire history with each update.  That's not a
> fundamentally hard issue, but it would definitely degrade darcs' ease of
> use, besides putting additional load on the server.  So if something like
> this were implemented, I think it would definitely have to be as an
> optional format.
> 
> Also, we couldn't actually store the data in CVS/SCCS format, since in
> darcs a patch to a single file isn't uniquely determined by two states of
> that file.  But storing separately the patches relevant to different files
> would definitely be an optimization worth considering.

What about just a cache file that records, for each "file" which patches
affect it.  Now that I think about it, this is a little tricky, since I'm
not sure what that file would be called.  It would be easy to do for
filenames in the current version.

Dave
