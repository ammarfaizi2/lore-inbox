Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289541AbSAOMqV>; Tue, 15 Jan 2002 07:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289546AbSAOMqH>; Tue, 15 Jan 2002 07:46:07 -0500
Received: from chmls20.mediaone.net ([24.147.1.156]:26852 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S289544AbSAOMoy>; Tue, 15 Jan 2002 07:44:54 -0500
Date: Tue, 15 Jan 2002 07:29:58 -0500
To: Bruce Harada <bruce@ask.ne.jp>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020115072958.A7900@pimlott.ne.mediaone.net>
Mail-Followup-To: Bruce Harada <bruce@ask.ne.jp>, esr@thyrsus.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020114125228.B14747@thyrsus.com> <20020114125508.A3358@twoflower.internal.do> <20020114135412.D17522@thyrsus.com> <20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there> <20020114173423.A23081@thyrsus.com> <20020115080218.7709cef7.bruce@ask.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115080218.7709cef7.bruce@ask.ne.jp>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 08:02:18AM +0900, Bruce Harada wrote:
> On Mon, 14 Jan 2002 17:34:23 -0500
> "Eric S. Raymond" <esr@thyrsus.com> wrote:
> 
> > Therefore I try to stay focused on Aunt Tillie even though I know
> > that you are objectively correct and her class of user is likely
> > not to build kernels regularly for some years yet.
> 
> Change that last line to read "her class of user will never build
> kernels ever, and would be aggressively disinterested in the
> possibility of doing so", and you might be closer to the truth.
> 
> Aunt Tillie just DOESN'T CARE, OK? She can talk to her vendor if she gets
> worried about whether her kernel supports the Flangelistic2000 SuperDoodad.

Ok, Grandpa Willie only cares about support for his doodad.  Why do
you conclude that he should never build a kernel?

It's just as easy in principle to write a friendly front-end that
downloads sources and compiles them, as one that downloads binaries.
The obstacle is reliability, because there are more things that can
go wrong.  But imagine for a moment that this is overcome.  What
benefits might accrue from Willie compiling his own kernels (even if
he doesn't realize it)?

- It's easier for third-parties to provide kernel software in source
  form than in binary form (because binaries must be in the correct
  package format, and be compiled with the right config options, and
  adhere to the particular distribution's conventionts; whereas
  source is relatively neutral).  Why should Willie be limited to
  getting his kernels from his vendor?  What if his vendor doesn't
  support the Flangelistic2000 SuperDoodad yet, but there's a solid
  driver available from a volunteer?  What if he hears the hype
  (sorry) about the low latency patch, and decides he wants to try
  it (maybe his MP3's skip when Netscape thrashes)?  Why take the
  choice out of Willie's hands?  And why keep a willing tester and a
  developer apart?  (If you claim that novice users don't want to
  install random beta software--that contradicts my experience with
  lots of Windows users!)

- It's a system that experts are likely to use as well, because
  there's a lot of overlap between this system and what experts
  want.  A nice front-end to browse and manage kernel versions,
  patches, and drivers; to download, configure, compile and install
  them?  I might use that.  Such a system helps more people, and
  thus attracts more developers.  It's more likely to become common
  infrastructure, instead of a distribution-specific one-off.

- It makes it easier for Willie's hacker grandson to help him.
  Hackers know all about compiling kernels, but aren't as likely to
  be familiar with the distribution's binary packaging.  The more we
  all do things the same way, the more we can help each other; when
  different groups use different tools, the community is fragmented.

- It can support a graceful transition from beginner to expert.
  Suppose one day, for whatever reason, Willie really does need to
  change a compile-time option.  Or, heaven forbid, he gets curious
  about what his computer is doing when the status line says
  "compiling".  He's already got all the pieces he needs.  Ideally,
  he just needs to click on that scary "Advanced options" button.

- Building from source is good karma.

You might think these are trifles and < 1% cases.  My intuition
tells me that they add up in the long run.  At least it's worth
considering.

Andrew
