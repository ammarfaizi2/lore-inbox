Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281102AbRKDSr4>; Sun, 4 Nov 2001 13:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280423AbRKDSqr>; Sun, 4 Nov 2001 13:46:47 -0500
Received: from unthought.net ([212.97.129.24]:51416 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S281103AbRKDSqa>;
	Sun, 4 Nov 2001 13:46:30 -0500
Date: Sun, 4 Nov 2001 19:46:28 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tim Jansen <tim@tjansen.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104194628.I14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tim Jansen <tim@tjansen.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <160Rpw-0rLDCyC@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <160Rpw-0rLDCyC@fmrl05.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 07:20:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:20:39PM +0100, Tim Jansen wrote:
> On Sunday 04 November 2001 18:28, Daniel Phillips wrote:
> > > It needs special parsers and will be almost impossible to access from
> > > shell scripts.
> > No, look, he's proposing to put the binary encoding in hidden .files.  The
> > good old /proc files will continue to appear and operate as they do now.
> 
> But as he already said:
> 2)  As /proc files change, parsers must be changed in userspace
> 
> So if only some programs use the 'dot-files' and the other still use the 
> crappy text interface we still have the old problem for scripts, only with a 
> much larger effort.

So we have a gradual transition - nothing breaks more than it does already,
and applications can migrate to the stable API over time.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
