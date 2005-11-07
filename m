Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVKGRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVKGRFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKGRFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:05:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932282AbVKGRFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:05:44 -0500
Date: Mon, 7 Nov 2005 09:02:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] GIT trivial tree
In-Reply-To: <20051107165126.GE3847@stusta.de>
Message-ID: <Pine.LNX.4.64.0511070856590.3193@g5.osdl.org>
References: <20051107165126.GE3847@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Nov 2005, Adrian Bunk wrote:
> 
>   http://www.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git

Please don't try to make me update over http. Either point to master 
(which is not accessible by all), or point to git://git.kernel.org/. Or do 
both..

And if you do the latter (or, in fact, rsync or http for others), please 
make sure that you delay your "please pull" sufficiently that the contents 
have actually mirrored out, because otherwise, if the mail comes in while 
I'm in merging mode (like right now), and I try to pull, I may not have 
anything to pull at all just because it hasn't mirrored out yet.

A side comment (this was true with BK too): I prefer not to see 
unnecessary two-way merges, since that just makes the history much 
messier. So

> Adrian Bunk:
>   Merge with http://www.kernel.org/.../torvalds/linux-2.6.git

is _probably_ unnecessary, since by definition the "trivial" tree should 
basically never have anything that could cause clashes (so if I just pull 
on it, it should merge fine even without you doing the merge the other 
way).

Anyway, I pulled, but now we have two merges instead of one, which is kind 
of pointless and unnecessary history complexity.

		Linus
