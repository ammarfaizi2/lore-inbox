Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbTCXXeC>; Mon, 24 Mar 2003 18:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbTCXXeC>; Mon, 24 Mar 2003 18:34:02 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:30128 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261296AbTCXXdy>; Mon, 24 Mar 2003 18:33:54 -0500
Date: Tue, 25 Mar 2003 10:45:56 +1100
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.65: *huge* interactivity problems
Message-ID: <20030324234556.GK621@zip.com.au>
References: <20030323231306.GA4704@elf.ucw.cz> <20030324171936.680f98e2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324171936.680f98e2.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 05:19:36PM -0800, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> > I'm having awfull interactivity problems. While lingvistic application
> > (slm from nltools.sf.net) is running, machine is unusable. I still can
> > read text in most, but can't login, can't run links, can't... For
> > minutes.
> > 
> > slm does a lot of computation over ~250MB dataset, but during stall
> > disk was not active.
> 
> Oh Pavel, this is more a whinge than a bug report.  You know better ;)

If he's seeing what I'm seeing then I can put my own answers to this. I
get freezups, lost keystrokes and eventual shutdown of the laptop. I can
reproduce it prettymuch at will be it a compilation of a piece of s/w,
the kernel, mozilla loading pages or whatnot.

> - How much memory does the machine have?

256

> - UP/SMP/preempt?

UP with and without preempt presents the same issues.

> - What do vmstat and top say?

My box never survived long enough for me to be able to look.

> - Did it happen in 2.5.64?  2.5.63?  2.4.20?

Never had this under 2.4, Not sure wchi version now as I went to 2.5
with this laptop as soon as the freeze came and I could back it up.

As for 2.5 I can definately say the sluggishness and freezes happen with
2.5.63+ (about to compile .66 and try it) but .63 does not turn the
laptop off for me and .64 takes a wee bit more punishment before dieing
on me.

> - Does it get better if you renice stuff?

>From memory, I niced (to lvl 19) a compile of mplayer that was killing
my laptop and it survived.

> - What steps should others take to reproduce it?

Not too sure. For me it's 'when compiling don't even think of looking at
an input device the wrong way or BOOM'.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
