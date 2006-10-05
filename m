Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWJFOwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWJFOwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWJFOwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:52:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42505 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161026AbWJFOwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:52:18 -0400
Date: Thu, 5 Oct 2006 12:40:37 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: wireless abi breakage (was Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA)
Message-ID: <20061005124036.GA4624@ucw.cz>
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com> <20060930193853.GA6890@ucw.cz> <20061002170832.GB14535@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002170832.GB14535@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 	That's exactly the point of this warning (some distro like to
> > > kill it), I think it spells pretty clearly what's wrong. Don't say I
> > > did not warn you...
> > 
> > Well... we are trying to have stable abi here. Breaking older wireless
> > tools randomly is *not* okay in the middle of stable series.
> 
> 	I'm sorry, but as there is no longer any "devel" serie, to me
> there is no longer any "stable" serie. Do you mean that we are going
> to get frozen with the same APIs until then end of time ? I don't
> think so...

I mean that proprt procedure for removing APIs needs to be followed,
and that is deprecating them in Doc*/feature-removal-schedule, along
with date, waiting a year, then removing them.

> 	You can see the glass half-full or half-empty. Maybe you can

No, not in this case.
-- 
Thanks for all the (sleeping) penguins.
