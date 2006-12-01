Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936492AbWLANIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936492AbWLANIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936491AbWLANIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:08:20 -0500
Received: from [139.30.44.16] ([139.30.44.16]:63031 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S936492AbWLANIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:08:20 -0500
Date: Fri, 1 Dec 2006 14:08:18 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: please pull from the trivial tree
In-Reply-To: <20061201125504.GC11084@stusta.de>
Message-ID: <Pine.LNX.4.63.0612011357230.7120@gockel.physik3.uni-rostock.de>
References: <20061201113740.GP11084@stusta.de>
 <Pine.LNX.4.63.0612011329130.3090@fink.physik3.uni-rostock.de>
 <20061201125504.GC11084@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006, Adrian Bunk wrote:

> On Fri, Dec 01, 2006 at 01:41:18PM +0100, Tim Schmielau wrote:
[...]
> > would leave a comment that is correct, but less useful (I'd expect any 
> > kernel hacker to know that u64 is non-atomic on many platforms).
> 
> 
> If kernel hackers are expected to already know it's non-atomic we could 
> remove the whole comment.
> 
> The comment regarding "volatile" was bogus since "volatile" wouldn't 
> help against getting garbage when reading an u64 variable.

Well, it's probably too trivial to argue about anyways - I don't mind much 
in either direction.

Tim
