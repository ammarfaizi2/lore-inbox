Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263277AbVFXVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbVFXVPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbVFXVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:15:42 -0400
Received: from iabervon.org ([66.92.72.58]:29445 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263277AbVFXVNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:13:33 -0400
Date: Fri, 24 Jun 2005 17:11:02 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
In-Reply-To: <pan.2005.06.24.13.16.10.406827@smurf.noris.de>
Message-ID: <Pine.LNX.4.21.0506241659070.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005, Matthias Urlichs wrote:

> Hi, Petr Baudis wrote:
> 
> > Switching branches in place will be supported soon (although I have
> > doubts about its usefulness).
> 
> Well, I don't. Main reason: It's simply a lot faster to create+switch to a
> branch locally for doing independent work, than to hardlink the whole
> Linux directory tree into a clone tree.

There's another option, which I may be the only person currently
using: have a repo (.git directory) not in a working directory, and have
the objects/ and refs/ subdirectories of the .git directories in your
working directories symlinked to those subdirectories of the repo. Then
you can have any number of functionally identical working directories,
each of which is set to some branch. If you have a reasonably small number
of branches at any time, they can each have a working directory switched
to them. On the other hand, all of the branches are accessible from any of
them.

	-Daniel
*This .sig left intentionally blank*

