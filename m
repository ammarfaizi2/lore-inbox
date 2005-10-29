Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVJ2VBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVJ2VBv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 17:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVJ2VBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 17:01:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750989AbVJ2VBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 17:01:50 -0400
Date: Sat, 29 Oct 2005 14:01:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Pitre <nico@cam.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <Pine.LNX.4.64.0510291609140.5288@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0510291358330.3348@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org>
 <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
 <Pine.LNX.4.64.0510291609140.5288@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2005, Nicolas Pitre wrote:
> 
> Since GIT is real free software that even purists may use without fear, 
> this downside is certainly not as critical as it was in the BK days.

I don't think that's the problem.

It's the learning curve. I don't think git is that hard to use (certainly 
not if you just follow somebody elses tree and occasionally do a "git 
bisect"), but git _is_ different. And if you're not a developer, or even 
if you are, and you're just somebody who has alway sjust used CVS, then 
something like "patch" is simply to understand what it's doing, with 
basically no abstractions anywhere. 

Compared to tar-files + patches, git has a _lot_ of abstract things going 
on that you have to get used to before you aren't intimidated by it.

And the thing is, the most important bug-reports often come from people 
who aren't necessarily developers - because they are the ones that see a 
bug that none of the developers saw.. So making it easy for people like 
that to test a few different versions is probably important.

		Linus
