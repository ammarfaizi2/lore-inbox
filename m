Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVADPWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVADPWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVADPWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:22:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53767 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261674AbVADPVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:21:39 -0500
Date: Tue, 4 Jan 2005 16:21:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Thomas Graf <tgraf@suug.ch>, "Theodore Ts'o" <tytso@mit.edu>,
       Bill Davidsen <davidsen@tmr.com>, Diego Calleja <diegocg@teleline.es>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104152136.GE3097@stusta.de>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <20050103185927.C3442@flint.arm.linux.org.uk> <20050104002452.GA8045@thunk.org> <20050104031229.GE26856@postel.suug.ch> <20050104053348.GB19945@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104053348.GB19945@alpha.home.local>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 06:33:48AM +0100, Willy Tarreau wrote:
> On Tue, Jan 04, 2005 at 04:12:29AM +0100, Thomas Graf wrote:
> > * Theodore Ts'o <20050104002452.GA8045@thunk.org> 2005-01-03 19:24
> > > On Mon, Jan 03, 2005 at 06:59:27PM +0000, Russell King wrote:
> > > > It is also the model we used until OLS this year - there was a 2.6
> > > > release about once a month prior to OLS.  Post OLS, it's now once
> > > > every three months or there abouts, which, IMO is far too long.
> > > 
> > > I was thinking more about every week or two (ok, two releases in a day
> > > like we used to do in the 2.3 days was probably too freequent :-), but
> > > sure, even going to a once-a-month release cycle would be better than
> > > the current 3 months between 2.6.x releases.
> > 
> > It definitely satifies many of the impatients but it doesn't solve the
> > stability problem. Many bugs do not show up on developer machines until
> > just right after the release (as you pointed out already). rc releases
> > don't work out as expected due to various reasons, i think one of them
> > is that rc releases don't get announced on the newstickers, extra work
> > is required to patch the kernel etc.
> 
> The problem with -rc is that there are two types of people :
>   - the optimists who think "good, it's already rc. I'll download it and
>     run it as soon as it's released"
>  - the pessimists who think "I killed my machine twice with rc, let's leave
>    it to other brave testers".
> 
> These two problems are solvable with the same solution : no rc anymore.
> I agree with Ted. A version every week or 2 weeks is good. People will
> run random versions, some will report problems, others not. After that,
> you know the differences between exact releases, you don't have to parse
> 28 MB changes. And you can also ask them to upgrade or downgrade and
> quickly find where the bug entered.
>...

This was the model for development kernels, and it's usable for 
development kernels.

The problem is that 28 MB in 9 weeks are 3 MB of changes every week.

With such a weekly model, I fear the weekly kernels would be of very 
varying quality and never fully stable. Up to 2.4, kernel.org kernels 
were usually a good choice, but with such a model the only usable 
kernels in production environments will be distribution kernels that 
will contain the mixture of at least three "stable" kernel for getting a 
usable kernel.

> Regards,
> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

