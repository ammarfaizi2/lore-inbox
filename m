Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268843AbTCBEio>; Sat, 1 Mar 2003 23:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268958AbTCBEio>; Sat, 1 Mar 2003 23:38:44 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:59652 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268843AbTCBEim>; Sat, 1 Mar 2003 23:38:42 -0500
Subject: Re: [PATCH] More spelling fixes: loose->lose
From: Steven Cole <elenstev@mesatop.com>
To: jw schultz <jw@pegasys.ws>
Cc: LKML <linux-kernel@vger.kernel.org>, Hugo Mills <hugo-lkml@carfax.org.uk>
In-Reply-To: <20030302031119.GB30797@pegasys.ws>
References: <20030301202807.GA24998@carfax.org.uk> 
	<20030302031119.GB30797@pegasys.ws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Mar 2003 21:47:50 -0700
Message-Id: <1046580472.2544.457.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 20:11, jw schultz wrote:
> On Sat, Mar 01, 2003 at 08:28:07PM +0000, Hugo Mills wrote:
> >    Loose, pronounced with a soft "s", as in the word "spelling", means
> > badly-fitting or vague.
> 
> Actually it means "not tight" or unconstrained as in "loosen
> the collar and check airflow before performing
> mouth-to-mouth" or "let loose the dogs"
> 
> In actual usage loose and lose can be antonyms when
> referring to priveleges.  "loose privs" vs "lose privs".
> 
> I found at least one case of correction that looked wrong so
> i perused the lot, see comments.
> 
> > diff -ur linux-2.5.63-orig/arch/ia64/kernel/perfmon.c linux-2.5.63/arch/ia64/kernel/perfmon.c
> > --- linux-2.5.63-orig/arch/ia64/kernel/perfmon.c	2003-03-01 16:19:41.000000000 +0000
> > +++ linux-2.5.63/arch/ia64/kernel/perfmon.c	2003-03-01 19:55:03.000000000 +0000
> > @@ -2995,7 +2995,7 @@
> >  		 * interruptible). In this case, the PMU will be kept frozen and the process will 
> >  		 * run to completion without monitoring enabled.
> >  		 *
> > -		 * Of course, we cannot loose notify process when self-monitoring.
> > +		 * Of course, we cannot lose notify process when self-monitoring.
> 
> This might have been "loosely notify" but careful examination of the
> context idicates it should be "lose notification process" or
> "lose the notify process". 

In my patch to Linus five days ago which fixed most of the lose/loose
substitutions, I left this one in, guessing that it might mean "let
loose 'notify process'".  I was wrong, so that error remains in the
tree.  Reference changeset currently numbered 1.1035.  Good catch.

Steven

