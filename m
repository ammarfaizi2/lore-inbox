Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262349AbREUCgO>; Sun, 20 May 2001 22:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262350AbREUCgF>; Sun, 20 May 2001 22:36:05 -0400
Received: from unthought.net ([212.97.129.24]:33712 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S262349AbREUCf7>;
	Sun, 20 May 2001 22:35:59 -0400
Date: Mon, 21 May 2001 04:35:53 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "Robert M. Love" <rml@tech9.net>
Cc: Jes Sorensen <jes@sunsite.dk>, John Cowan <jcowan@reutershealth.com>,
        esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010521043553.C20911@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"Robert M. Love" <rml@tech9.net>, Jes Sorensen <jes@sunsite.dk>,
	John Cowan <jcowan@reutershealth.com>, esr@thyrsus.com,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com> <d31ypj1r4y.fsf@lxplus015.cern.ch> <990411054.773.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <990411054.773.0.camel@phantasy>; from rml@tech9.net on Sun, May 20, 2001 at 10:10:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 10:10:49PM -0400, Robert M. Love wrote:
> On 21 May 2001 02:29:17 +0200, Jes Sorensen wrote:
> > John> Au contraire.  It is very reasonable to have both python and
> > John> python2 installed.  Having two different gcc versions installed
> > John> is a big pain in the arse.
> > 
> > It's not unreasonable to have both installed, it's unreasonable to
> > require it.
> > 
> > Eric seems to think he can tell every distributor to ship Python2
> > tomorrow. Well it's a fine dream but it's not going to happen; <snip>
> 
> I think this is a very important point, and one I agree with.  I tend to
> let my distribution handle stuff like python.  now, I use RedHat's
> on-going devel, RawHide. it is not using python2.  in fact, since
> switching to python2 may break old stuff, I don't expect python2 until
> 8.0. that wont be for 9 months.  90% of RedHat's configuration tools, et
> al, are written in python1 and they just are not going to change on
> someone's whim.

2.6.0 isn't going to happen for at least a year or two.  What's the problem ?

Want 2.5.X ?  Get the tools too.

I'm in no position to push people around, but I think the whining about CML2
tool requirements is completely unjustified.  If we required that everything
worked with GCC 2.7.2 and nmake, where would we be today ?   I'm a lot more
worried about CML2 itself than about the tools it requires   :)

> 
> im not installing python2 from source just so i can run some new config
> utility.

python2 will be in rawhide when 2.5 development requires it, if I'm not much
mistaken.

Whether CML2 requires python2 or not, the distributions will change. This is
not about Eric pushing something down people's throats. Tools evolve, and new
revisions introduce incompatibilities, but distributions still follow the
evolution.  Nobody ships perl4 today either.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
