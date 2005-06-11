Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVFKBrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVFKBrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 21:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFKBrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 21:47:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9204 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261512AbVFKBre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 21:47:34 -0400
Date: Fri, 10 Jun 2005 18:47:51 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611014751.GQ1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A73D15.6080201@nortel.com> <20050608192853.GE1295@us.ibm.com> <42AA133D.1050102@lifl.fr> <20050610230433.GI1300@us.ibm.com> <42AA20F6.9030606@lifl.fr> <20050611005934.GM1300@us.ibm.com> <42AA407C.2070104@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42AA407C.2070104@lifl.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 03:38:04AM +0200, Eric Piel wrote:
> 11.06.2005 02:59, Paul E. McKenney wrote/a écrit:
> >On Sat, Jun 11, 2005 at 01:23:34AM +0200, Eric Piel wrote:
> >>What about using the way you wrote it at the beginning of the section:
> >>"Probability of missing a deadline only because of a hardware failure"
> >
> >
> >Good point, I may just need to invert the whole thing, so that it
> >becomes something like:
> >
> >	i.	Probability of missing a deadline due to software,
> >		ranging from 0 to 1, with the value of 0 corresponding
> >		to the hardest possible hard realtime.
> >
> >But then the "p^n" becomes "1-(1-p)^n".  Bleah.
> Yes, it seems language doesn't fit well with mathematics ;-)

Hey, it could be worse.  I am just glad that it is not normally necessary
to do integration by parts, trig substitutions, or Laplace transforms
on English sentences!!!  ;-)

> >OK, how about the following?
> >
> >	i.	Probability of meeting a deadline in absence of hardware
> >		failure, ranging from 0 to 1, with the value of 1
> >		corresponding to the hardest possible hard realtime.
> >
> Sounds good!

OK, I made the change!  Thank you for catching this one, good eyes!

						Thanx, Paul
