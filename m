Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSFLJRb>; Wed, 12 Jun 2002 05:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSFLJRa>; Wed, 12 Jun 2002 05:17:30 -0400
Received: from [195.157.147.30] ([195.157.147.30]:57862 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S316289AbSFLJR3>; Wed, 12 Jun 2002 05:17:29 -0400
Date: Wed, 12 Jun 2002 10:18:25 +0100
From: Sean Hunter <sean@uncarved.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Richard Guy Briggs <rgb@conscoop.ottawa.on.ca>,
        "David S. Miller" <davem@redhat.com>, davidsen@tmr.com,
        greearb@candelatech.com, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
Message-ID: <20020612101825.E17812@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	Mark Mielke <mark@mark.mielke.cc>,
	Richard Guy Briggs <rgb@conscoop.ottawa.on.ca>,
	"David S. Miller" <davem@redhat.com>, davidsen@tmr.com,
	greearb@candelatech.com, cfriesen@nortelnetworks.com,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20020609.213440.04716391.davem@redhat.com> <Pine.LNX.3.96.1020611183218.29598A-100000@gatekeeper.tmr.com> <20020611.204119.58650447.davem@redhat.com> <20020611235726.P25193@grendel.conscoop.ottawa.on.ca> <20020612012004.A15773@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 01:20:04AM -0400, Mark Mielke wrote:
> On Tue, Jun 11, 2002 at 11:57:26PM -0400, Richard Guy Briggs wrote:
> > Basically Bill, if you don't like this policy, fork the code. That
> > is one of the strengths (and weaknesses) of open source. If your
> > tree works better and gets wider use, then something about it must
> > be better. If not, then maybe it wasn't. This community works on
> > reputation capital (and some diplomacy).
>
> To some degree (i.e. I know it is not intentional), this comes across
> as blackmail.
>
> Sorta like "if you want to play ball with me, you play by my rules,
> otherwise you can go find your own diamond and your own friends to
> play with."
>
> I would still like to see David's logic as to why the approach is bad.

Perhaps the reason David Miller is the network stack maintainer is that
he can see things that you can't see? The onus is on you (as proposer)
to show _him_ that a change is worthwhile, not the other way round.
Don't be confused into thinking this is some sort of democracy.

> So far it amounts to 1) David doesn't like it, 2) David doesn't see a
> need for it, or can see other less adequate methods of approximating
> the same effect, and 3) David suspects that it will effect the
> performance of all users to provide a limited gain for some
> applications.

Yup. What you've left out is:

4)David has demonstrated that he knows his stuff by high-quality work
  over a long period of time
5)You haven't.
6)Because he is the network maintainer you need to convince him and you
  haven't done so.

> 'Reputation capital' is earned. I would like to see it 'earned' in
> practice given a real requirement from a real developer on a real
> world class application.
>
> Statements such as 'the most important thing I do is say no', don't
> convince me that a reputation is deserved. The extreme of this is that
> an automaton could say no to everything.

Bollocks. Its plainly ridiculous to impugne David Miller and imply his
reputation isn't earned. You or I or your straw automaton could say
"no", but it doesn't mean anyone will listen.

Furthermore, I would propose that the Linux TCP/IP networking stack is "world
class" and has earned David Miller (and others) a fair bit of "reputation
capital", and that's why he (and not you or I) is where he is.

> Yes, I might be testing David... is it fair? Well, the requirement was
> fair, so how could it not be fair?
>
> I (and Bill) are just asking for some logic to show us where we are
> wrong. Linus can pull the "I'm god, and that's that" gig. Fine. How
> far does the godhead extend? Who else can pull this gig?

Show why it should be in the main tree and not just a debugging patch.

> I am waiting in anticipation to be shown the error of my ways using
> proper logic and iron clad reasoning... :-)

I think its more like Dave M et al are waiting for someone to show the
slightest bit of evidence to say this isn't better off as just a
debugging patch rather than just waving hands and talking bollocks.


Sean
