Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTJWWu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJWWu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 18:50:58 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:28428 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261841AbTJWWu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 18:50:57 -0400
Date: Thu, 23 Oct 2003 23:50:48 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Ben Collins <bcollins@debian.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
In-Reply-To: <20031023144315.GA667@phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0310232343410.21561-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The cursor has changed from a nice underline to a solid white block. 

I seen the problem. Its the wrong color for the background color for the 
cursor. I haven't been able to figure out why it went wrong. The specs are 
not to clear on this.

> Not only that,
> but the block is bigger than the font it is over (if I am on top of
> adjacent letters, it covers the entire letter I am on, plus a couple of
> pixels of the letter to the right).

Ug. That code is straight from the old driver. Will fix.

> In additition, the cursor now disappears while typing, and navigating
> around (on the command line left and right, or even in an editor when
> moving the cursor up and down). This disappearing while typing or
> navigating is _really_ annoying. If I go left or right a lot, I have to
> keep stopping to see where the cursor actually is.

I seen this problem last night with the NVIDIA fbdev driver. I think I 
know what the problem is. I will try a fix tonight. 


