Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVFVQmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVFVQmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVFVQiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:38:22 -0400
Received: from mbox1.netikka.net ([213.250.81.202]:11227 "EHLO
	mbox1.netikka.net") by vger.kernel.org with ESMTP id S261633AbVFVQdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:33:40 -0400
Date: Wed, 22 Jun 2005 19:33:32 +0300 (EEST)
From: johan.heikkila@netikka.fi
X-X-Sender: jukk@localhost.localdomain
Reply-To: johan.heikkila@netikka.fi
To: Joerg Sommrey <jo@sommrey.de>
cc: Tony Lindgren <tony@atomide.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Juergen Brunk <Juergen.Brunk@eurolog.com>, johan.heikkila@netikka.fi,
       Tarmo Jarvalt <tarmo.jarvalt@mail.ee>,
       Johnathan Hicks <thetech@folkwolf.net>
Subject: Re: [PATCH 2.6.12] amd76x_pm: C2 powersaving for AMD K7
In-Reply-To: <20050621202035.GE31391@atomide.com>
Message-ID: <Pine.LNX.4.58.0506221917260.11779@localhost.localdomain>
References: <20050620205334.GA28230@sommrey.de> <20050621202035.GE31391@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Tony Lindgren wrote:

> * Joerg Sommrey <jo@sommrey.de> [050620 13:54]:
> > This is a processor idle module for AMD SMP 760MP(X) based systems.
> > The patch was originally written by Tony Lindgren and has been around
> > since 2002.  It enables C2 mode on AMD SMP systems and thus saves
> > about 70 - 90 W of energy in the idle mode compared to the default idle
> > mode.  The idle function has been rewritten and now should be free of
> > locking issues and is independent from the number of CPUs.  The impact
> > from this module on the system clock has been reduced. 
> > 
> > This patch can also be found at
> > http://www.sommrey.de/amd76x_pm/amd_76x_pm-2.6.12-jo1.patch
> 
> Cool. Just once comment:
> 
> > +// #define AMD76X_NTH 1
> > +// #define AMD76X_POS 1
> > +// #define AMD76X_C3 1
> 
> How about separating all this ifdef code into a separate debug patch on top
> of the amd_76x_pm patch? Or just leave it out as I don't think anybody is
> using it. It would shrink down the patch quite a bit and make it more
> readable.
> 
> I won't be able to access my dual athlon box until September, so I'm not
> much of help with this module :)
> 
> Regards,
> 
> Tony
> 

I have been running with the 2.6.11-jo3 patch since Joerg made it 
available. It works fine on my ASUS A7M266-D with two Athlon MP1800+ that 
is running 24h. I just patched 2.6.12 vanilla kernel and it looks 
good. I will report if there are any issues.

regards,
Johan
