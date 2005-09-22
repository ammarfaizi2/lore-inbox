Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbVIVQwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbVIVQwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVIVQwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:52:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030445AbVIVQwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:52:55 -0400
Date: Thu, 22 Sep 2005 09:52:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Rolf Offermanns <roffermanns@sysgo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linus GIT tree disappeared from http://www.kernel.org/git/?
In-Reply-To: <200509221131.41838.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0509220944220.2553@g5.osdl.org>
References: <200509221514.44027.roffermanns@sysgo.com>
 <20050922133228.GB26438@flint.arm.linux.org.uk> <200509221131.41838.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Sep 2005, Gene Heskett wrote:
> 
> I have made 4 passes at re-grabbing the 2.6.14-rc2 with git, and each
> time it exits with an error, but the tree it grabs looks to be ok. 

This is a buglet in "git fetch", which only happens with rsync, I think.

> The error:
> "/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/alternates"
> (in pub) failed: No such file or directory (2)

Ignore it. It gives this warning because I don't have an alternates 
directory, but it really shouldn't. _Most_ archives don't have alternates.

It's fixed in the current git already. I thought it was fixed in 0.99.7 
already, but regardless, this error is harmless and should just be 
ignored.

		Linus
