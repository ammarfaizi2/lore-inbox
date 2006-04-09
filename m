Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWDISca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWDISca (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWDISca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:32:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:21463 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750723AbWDISca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:32:30 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200604091944.28954.a1426z@gawab.com>
References: <200604091944.28954.a1426z@gawab.com>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 20:33:16 +0200
Message-Id: <1144607596.7408.34.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-09 at 19:44 +0300, Al Boldi wrote:
> bert hubert wrote:
> > On Sun, Apr 09, 2006 at 01:39:38PM +0200, Mike Galbraith wrote:
> > > Ok, unusable may be overstated.  Nonetheless, that bit of code causes
> > > serious problems.  It makes my little PIII/500 test box trying to fill
> > > one 100Mbit local network unusable.  That is not overstated.
> >
> > If you try to make a PIII/500 fill 100mbit of TCP/IP using lots of
> > different processes, that IS a corner load.
> >
> > I'm sure you can fix this (rare) workload but are you very sure you are
> > not killing off performance for other situations?
> 
> This really has nothing to do w/ workload but rather w/ multi-user processing 
> /tasking /threading.  And the mere fact that the 2.6 kernel prefers 
> kernel-threads should imply an overall performance increase (think pdflush).
> 
> The reason why not many have noticed this scheduler problem(s) is because 
> most hackers nowadays work w/ the latest fastest hw available which does not 
> allow them to see these problems (think Windows, where most problems are 
> resolved by buying the latest hw).
> 
> Real Hackers never miss out on making their work run on the smallest common 
> denominator (think i386dx :).

Please don't trim the cc list.  I almost didn't see this, and I really
do want to hear each and every opinion.

	-Mike

