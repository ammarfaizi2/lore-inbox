Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVJ3SE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVJ3SE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVJ3SE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:04:29 -0500
Received: from waste.org ([216.27.176.166]:27273 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932093AbVJ3SE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:04:28 -0500
Date: Sun, 30 Oct 2005 09:59:11 -0800
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
Message-ID: <20051030175911.GS4367@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain> <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain> <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain> <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain> <20051030011959.GA17750@vasa.acc.umu.se> <Pine.LNX.4.58.0510292343280.10073@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510292343280.10073@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 11:48:07PM -0400, Steven Rostedt wrote:
> 
> On Sun, 30 Oct 2005, David Weinehall wrote:
> >
> > Uhm, this patch assumes that you're using bash as /bin/sh.
> > Not everyone does.  (I haven't checked the rest of the system calls
> > in ketchup though, maybe this is a more generic problem?)
> 
> OK, if I work any more on ketchup, I'm going to convert the whole damn
> thing into perl! ;-} (and call it "mustard").
> 
> Is this patch better? It even tests the version of tar and if it is less
> than 1.15 it uses --strip-path (the old name) and if it is 1.15 or greater
> it uses --strip-components (the new name).  And if it fails the version
> test all together, it goes back to the old (broken) method of just moving
> the contents.
> 
> Is this robust enough for you?

Yep, looks good. Applied and pushed.

-- 
Mathematics is the supreme nostalgia of our time.
