Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWJEW7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWJEW7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWJEW7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:59:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932172AbWJEW7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:59:46 -0400
Date: Thu, 5 Oct 2006 15:59:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
In-Reply-To: <200610051927.27255.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610051556330.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de> <Pine.LNX.4.64.0610051014550.3952@g5.osdl.org>
 <200610051927.27255.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Oct 2006, Andi Kleen wrote:
> 
> Ok. Please drop them then.

Ok, done. Since they weren't the last commits in your branch, I had to do 
a certain amount of hand-waving: I merged up to the commit preceding the 
AC flag changes, and then I cherry-picked the one later commit separately.

So it's not a normal merge, since I wanted to avoid those two commits.

I've pushed out the result, you should check it out (and drop the top 
three commits on your head once you're ok with my result, since they won't 
exist in my tree).

		Linus
