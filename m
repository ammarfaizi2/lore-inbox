Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTLODrY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 22:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTLODrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 22:47:24 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:22190 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263057AbTLODrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 22:47:22 -0500
Date: Sun, 14 Dec 2003 19:47:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       bitkeeper-users@bitmover.com
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215034716.GC16554@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Keith Owens <kaos@ocs.com.au>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org, bitkeeper-users@bitmover.com
References: <20031214234423.GB15850@work.bitmover.com> <3034.1071447911@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3034.1071447911@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 11:25:11AM +1100, Keith Owens wrote:
> On Sun, 14 Dec 2003 15:44:23 -0800, 
> Larry McVoy <lm@bitmover.com> wrote:
> >On Mon, Dec 15, 2003 at 10:05:03AM +1100, Keith Owens wrote:
> >> On Sun, 14 Dec 2003 09:21:56 -0800, 
> >> Larry McVoy <lm@bitmover.com> wrote:
> >> >I've prototyped an extension to BitKeeper that provides tarballs
> >> >and patches.  ...
> >> >... You need to understand that this is all you get,
> >> >we're not going to extend this so you can do anything but track the most
> >> >recent sources accurately.  No diffs.  No getting anything but the most
> >> >recent version.  No revision history.  
> >> 
> >> Do we get the changelogs from each BK check in?  Without the
> >> changelogs, patches are going to be much less useful.
> >
> >You already get those, use BK/Web.  It's all there and always has been.
> 
> Using update and BK/Web means manually reconciling two sets of data
> which may have different time bases.  If update has not been run for 23
> days, the user has to look at "Changesets in the last four weeks" and
> manually determine where in that log of 119 changesets (linux-2.5)
> their last update was done before they know which changesets are in the
> current update.
> 
> What about this, assuming it does not give away information that you
> believe will be used for $SCM.  Treat the BK changelog as a file, and
> have update generate a patch from the last update for the changelog as
> well as the project files.

That would be what the BK2CVS export does.  It's perfect for what you want,
use it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
