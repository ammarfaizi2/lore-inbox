Return-Path: <linux-kernel-owner+w=401wt.eu-S965341AbXAKKYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbXAKKYO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbXAKKYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:24:13 -0500
Received: from twin.jikos.cz ([213.151.79.26]:50718 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965341AbXAKKYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:24:13 -0500
Date: Thu, 11 Jan 2007 11:21:23 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Adrian Bunk <bunk@stusta.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <john@johnmccutchan.com>, rml@novell.com,
       Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v3)
In-Reply-To: <20070111084554.GF21724@stusta.de>
Message-ID: <Pine.LNX.4.64.0701111119180.16747@twin.jikos.cz>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <20070111051022.GA21724@stusta.de> <45A5DCAB.6060900@yahoo.com.au>
 <20070111084554.GF21724@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, Adrian Bunk wrote:

> > >Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
> > >References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
> > >Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
> > >Handled-By : John McCutchan <john@johnmccutchan.com>
> > >Status     : problem is being debugged
> > I'm not sure that this is actually a regression for 2.6.20-rc.
> The submitter says it doesn't occur in 2.6.19.

Any chance that the submitter could do git bisect? (added to CC). From the 
bugzilla entry it seems to be well reproducible for him.

-- 
Jiri Kosina
