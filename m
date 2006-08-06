Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWHFGdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWHFGdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 02:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWHFGdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 02:33:00 -0400
Received: from 1wt.eu ([62.212.114.60]:34061 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751540AbWHFGc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 02:32:59 -0400
Date: Sun, 6 Aug 2006 08:17:27 +0200
From: Willy Tarreau <w@1wt.eu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060806061727.GA6765@1wt.eu>
References: <20060803204921.GA10935@kroah.com> <625fc13d0608031943m7fb60d1dwb11092fb413f7fc3@mail.gmail.com> <20060804230017.GO25692@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804230017.GO25692@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sat, Aug 05, 2006 at 01:00:17AM +0200, Adrian Bunk wrote:
> On Thu, Aug 03, 2006 at 09:43:06PM -0500, Josh Boyer wrote:
> > On 8/3/06, Greg KH <greg@kroah.com> wrote:
> > >This is just a notice to everyone that Adrian is going to now be taking
> > >over the 2.6.16-stable kernel branch, for him to maintain for as long as
> > >he wants to.
> > 
> > Adrian, could you provide a bit of rationale as to why you want to do
> > this?  I'm just curious.
> 
> A long-term maintained stable series was missing in the current 
> development model.
> 
> The 2.6 series itself is theoretically a stable series, but the amount 
> of regressions is too big for some users.

Well, I really wish you success on this project. I completely agree on the
need of a 2.4-like model to stabilize one branch of 2.6, and you probably
remember that we've been talking about this 1 or 2 years ago, when I found
it too hard to be started alone. It takes a very long time but apparently
succeeds in the long term. I think it will quickly become a hard work because
patches will get harder and harder to apply, and sometimes you'll have to
adapt them a lot. But there's nothing impossible, I've been backporting
fixes from 2.6 to 2.4 for a long time, so 2.6 to 2.6 should be feasible.

However, I hope that you realize that (if you succeed), your work might
become a basis for some distros, as well as for some admins who will try
to switch from 2.4 to 2.6. I mean, people will be *relying* on you to get
fixes.

But for this, you will have to be seen as a serious person, and avoid
childish fighting with other kernel developpers, such as this :

>     Gentoo kernels are 42 times more popular than SUSE kernels among
>     KLive users  (a service by SUSE contractor Andrea Arcangeli that
>     gathers data about kernels from many users worldwide).

People who know the history will take this a as the teenager trying to
take revenge on the other guy who stole his girlfriend, and people not
aware of the history will take this for Gentoo advertisement based on
the work of your good friend Andrea who is so much honnest that he doesn't
mind publishing such results. In both cases, I think this is not what
you're looking for, and it does not make you look like the serious guy
on whom we can rely to get a stable kernel. At best, it will be used to
show that Andrea is unbiased, which is exactly what is expected for the
role you're taking.

And BTW, you'll look ridiculous when you'll post changelogs which will
start with fixes from Andrea and will end with this signature ! Or maybe
you'll decide to refuse his patches, which is a dangerous game when the
original goal is to stabilize some code. I hope that everyone will grow
up in order not to tarnish linux's image. There are already a few debian
extremists to make us look like immature geeks in enterprise contexts,
I think we don't need more of this.

Best wishes with 2.6.16,
Willy

