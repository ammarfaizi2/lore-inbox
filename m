Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUJYWEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUJYWEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUJYWEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:04:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:23719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261313AbUJYWCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:02:34 -0400
Date: Mon, 25 Oct 2004 15:02:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
In-Reply-To: <417D7089.3070208@tmr.com>
Message-ID: <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org><Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
 <4179F81A.4010601@yahoo.com.au> <417D7089.3070208@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Oct 2004, Bill Davidsen wrote:
> 
> I do agree that the pre and rc names gave a strong hint that (-pre) new 
> features would be considered or (-rc) it's worth doing more serious 
> testing.

Well, I actually do try to _explain_ in the kernel mailing list 
annoucements what it going on.

One of the reasons I don't like "-rcX" vs "-preX" is that they are so 
meaningless. In contrast, when I actually do the write-up on a patch, I 
tend to explain what I expect to have changed, and if I feel we're getting 
ready for a release, I'll say something like

	..

	Ok,
	 trying to make ready for the real 2.6.9 in a week or so, so please give
	this a beating, and if you have pending patches, please hold on to them
	for a bit longer, until after the 2.6.9 release. It would be good to have
	a 2.6.9 that doesn't need a dot-release immediately ;)

	....

which is a hell of a lot more descriptive, in my opinion.

Which is just another reason why the name itself is not that meaningful. 
It can never carry the kind of information that people seem to _expect_ it 
to carry. 

		Linus
