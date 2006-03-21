Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWCUXwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWCUXwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWCUXwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:52:20 -0500
Received: from iabervon.org ([66.92.72.58]:22282 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751296AbWCUXwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:52:19 -0500
Date: Tue, 21 Mar 2006 18:53:50 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <Pine.LNX.4.64.0603211126290.3622@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603211829430.6773@iabervon.org>
References: <20060320150819.PS760228000000@infradead.org> 
 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>  <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
  <1142962995.4749.39.camel@praia>  <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
  <1142965478.4749.58.camel@praia>  <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
 <1142968537.4749.96.camel@praia> <Pine.LNX.4.64.0603211126290.3622@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Linus Torvalds wrote:

> On Tue, 21 Mar 2006, Mauro Carvalho Chehab wrote:
> > 
> > Weird, I can't see all those stuff here. It shows something like
> > (running from master copy at kernel.org):
> 
> I just did the raw output, so my output was from
> 
> 	git show --pretty=fuller -r e338b7
> 
> which isn't the default, but it's useful if you want to see both committer 
> and author information (and the raw format is just because I wasn't 
> interested in the diff itself, just looking at how many files where 
> changed).
> 
> > So, after the merging message, I have a normal diff with:
> > 
> >  179 files changed, 1274 insertions(+), 785 deletions(-)
> 
> Yeah, we're talking about the same commit.
> 
> > Seeming all perfect from my knowledge about git.
> 
> It's a perfectly good commit. BUT IT IS NOT A MERGE, AND IT IS NOT A DIFF 
> THAT I WANT TO SEE COMING IN FROM AN OUTSIDE TREE!

Isn't this what you'd get if you accidentally removed .git/MERGE_HEAD 
while trying to resolve a merge, and then absent-mindedly described what 
you'd done in the commit message (forgetting that it ought to have 
generated the commit message for you in this situation)?

I expect the source of the bad commit is losing that, although I don't 
know any obvious way to lose it (and still have the index contents which 
you're merging).

	-Daniel
*This .sig left intentionally blank*
