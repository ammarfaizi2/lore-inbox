Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422883AbWI3ByK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbWI3ByK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422882AbWI3ByK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:54:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932410AbWI3ByJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:54:09 -0400
Date: Fri, 29 Sep 2006 18:54:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Please pull x86 update
In-Reply-To: <200609300155.26250.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609291851430.3952@g5.osdl.org>
References: <200609300155.26250.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Andi Kleen wrote:
> 
> Linus,  please pull from
> 
> 	git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus

Do we haev a typo again, or perhaps a forgotten-to-execute git-daemon:

	fatal: unexpected EOF
	Fetch failure: git://one.firstfloor.org/home/andi/git/linux-2.6

(git-daemon is fairly security-conscious, so it won't actually tell you 
what's wrong - quite on purpose. I didn't want people to be able to just 
try different paths to see if certain files exist, so the anonymous 
daemon basically gives no indication of why it's unhappy)

		Linus
