Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277512AbRKDCI7>; Sat, 3 Nov 2001 21:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277530AbRKDCIt>; Sat, 3 Nov 2001 21:08:49 -0500
Received: from unthought.net ([212.97.129.24]:19922 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S277512AbRKDCIe>;
	Sat, 3 Nov 2001 21:08:34 -0500
Date: Sun, 4 Nov 2001 03:08:32 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Tim Jansen <tim@tjansen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-ID: <20011104030832.C26842@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Rusty Russell <rusty@rustcorp.com.au>, Tim Jansen <tim@tjansen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <15zGYm-1gibkeC@fmrl05.sul.t-online.com> <20011102132014.41f2d90a.rusty@rustcorp.com.au> <20011104013951Z16981-4784+741@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20011104013951Z16981-4784+741@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Sun, Nov 04, 2001 at 02:40:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 02:40:51AM +0100, Daniel Phillips wrote:
> On November 2, 2001 03:20 am, Rusty Russell wrote:
> > I agree with the "one file, one value" idea.
> 
> So cat /proc/partitions goes from being a nice, easy to read and use human 
> interface to something other than that.  Lets not go overboard.

/proc is usually a very nice interface that's both human- and machine-readable.
Some changes have gone in though (such as /proc/mdstat) that makes the proc
files implement something more like a pretty-printing user interface with
text-mode progress bars and what not.  That's a PITA to parse.

Now, if established files in proc could just be stable, so that they would not
change unless non-backwards-compatible information absolutely must be
presented, that would be a major step in the right direction.  Further, if we
could find some acceptable compromise between human- and machine- readability,
as has happened in the past...

Then, someone might just implement the equivalent of kstat (from Solaris) or
pstat (from HP-UX).   Under a license so that commercial players could actually
link to the library as well (unlike the gproc library).

So call me a dreamer   ;)

(For the record, it's not unlikely that I would be able to dedicate some
 time to that effort in a not too distant future - say, 2.5 ?)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
