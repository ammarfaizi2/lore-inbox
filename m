Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbREUCK7>; Sun, 20 May 2001 22:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262341AbREUCKt>; Sun, 20 May 2001 22:10:49 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:46124 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262334AbREUCKl>; Sun, 20 May 2001 22:10:41 -0400
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
From: Robert "M." Love <rml@tech9.net>
To: Jes Sorensen <jes@sunsite.dk>
Cc: John Cowan <jcowan@reutershealth.com>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <d31ypj1r4y.fsf@lxplus015.cern.ch>
In-Reply-To: <20010505192731.A2374@thyrsus.com>
	<d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com>
	<d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com>
	<d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com> 
	<d31ypj1r4y.fsf@lxplus015.cern.ch>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 20 May 2001 22:10:49 -0400
Message-Id: <990411054.773.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2001 02:29:17 +0200, Jes Sorensen wrote:
> John> Au contraire.  It is very reasonable to have both python and
> John> python2 installed.  Having two different gcc versions installed
> John> is a big pain in the arse.
> 
> It's not unreasonable to have both installed, it's unreasonable to
> require it.
> 
> Eric seems to think he can tell every distributor to ship Python2
> tomorrow. Well it's a fine dream but it's not going to happen; <snip>

I think this is a very important point, and one I agree with.  I tend to
let my distribution handle stuff like python.  now, I use RedHat's
on-going devel, RawHide. it is not using python2.  in fact, since
switching to python2 may break old stuff, I don't expect python2 until
8.0. that wont be for 9 months.  90% of RedHat's configuration tools, et
al, are written in python1 and they just are not going to change on
someone's whim.

im not installing python2 from source just so i can run some new config
utility.

(on another note, about the coexist issue: am i going to have a python
and python2 binary? so now the config tool will find which to use, ala
the kgcc mess? great)

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

