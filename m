Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbUJ1Ihw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbUJ1Ihw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUJ1Ihw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:37:52 -0400
Received: from rage.4t2.com ([217.20.115.48]:64645 "EHLO rage.4t2.com")
	by vger.kernel.org with ESMTP id S262831AbUJ1Ieb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:34:31 -0400
Date: Wed, 27 Oct 2004 22:08:05 +0200
From: "l_linux-kernel@mail2news.4t2.com" <ThomasWeber@abyss.4t2.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041027200805.GA17759@4t2.com>
References: <4179F81A.4010601@yahoo.com.au> <417D7089.3070208@tmr.com> <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
X-4t2Systems-MailScanner: Found to be clean
X-4t2Systems-MailScanner-From: thomasweber@abyss.4t2.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:02:12PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 25 Oct 2004, Bill Davidsen wrote:
> > 
> > I do agree that the pre and rc names gave a strong hint that (-pre) new 
> > features would be considered or (-rc) it's worth doing more serious 
> > testing.
> 
> Well, I actually do try to _explain_ in the kernel mailing list 
> annoucements what it going on.
> 
> One of the reasons I don't like "-rcX" vs "-preX" is that they are so 
> meaningless. In contrast, when I actually do the write-up on a patch, I 
> tend to explain what I expect to have changed, and if I feel we're getting 
> ready for a release, I'll say something like
> 
> 	..
> 
> 	Ok,
> 	 trying to make ready for the real 2.6.9 in a week or so, so please give
> 	this a beating, and if you have pending patches, please hold on to them
> 	for a bit longer, until after the 2.6.9 release. It would be good to have
> 	a 2.6.9 that doesn't need a dot-release immediately ;)
> 
> 	....
> 
> which is a hell of a lot more descriptive, in my opinion.

Indeed. But you hide this kind of information very carefully.
Announcing with a subject like this one isn't very descriptive.
Also the majority of kernel downloaders probably don't read lkml at
all. So how should they figure out?

It would be very helpful if you could please include at least your 
announcement in the changelog or some other file on kernel.org.
The changelog as of now is probably technically correct, but way to specific
and large for the average non kernel hacker - go ask someone who's happy
to get a kernel compiled by himself.

I don't care that much about the whole development model and the
numbering system as long as I can find the information above without 
reading hundreds of lkml lists daily. I guess most of the average users
out there would think alike. You just don't address them right now.

  Tom

ps:
  using -rc suffix which everywhere else uses for release candidate
  isn't a good choice. The -pre and -rc known from earlier kernels were
  much more intuitive. Personally I'd even prefer something like
  x.y.LATEST - x.y.LATEST-test{1,2..} - x.y.NEXT-rc{1,2,..} - x.y.NEXT

