Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRKDTAX>; Sun, 4 Nov 2001 14:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRKDTAO>; Sun, 4 Nov 2001 14:00:14 -0500
Received: from unthought.net ([212.97.129.24]:52952 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S273364AbRKDS77>;
	Sun, 4 Nov 2001 13:59:59 -0500
Date: Sun, 4 Nov 2001 19:59:55 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104195955.K14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104184839.F14001@unthought.net> <160S2o-1JXpD6C@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <160S2o-1JXpD6C@fmrl05.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 07:34:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:34:00PM +0100, Tim Jansen wrote:
> On Sunday 04 November 2001 18:48, you wrote:
> > > Is there is a way to implement a filesystem in user-space? What you could
> > You're proposing a replacement of /proc ?
> 
> I was asking whether there is a way to do compatibility stuff and human 
> readable interfaces in user space. 

Probably.

I'm just trying to:
1)  Supplement an unstable "API sort-of-thing" with something
    that's stable and can last.
2)  Come up with a realistic idea that can be implemented, tested,
    and deemed "obviously correct" and "good" in finite time
3)  Not break stuff more than it already is, and allow for a gradual
    transition to something that won't break mysteriously every ten
    kernel releases.

The idea is that if the userland application does it's parsing wrong, it should
either not compile at all, or abort loudly at run-time, instead of getting bad
values "sometimes".

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
