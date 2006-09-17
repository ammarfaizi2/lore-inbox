Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWIQKEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWIQKEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 06:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWIQKEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 06:04:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:33504 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964854AbWIQKEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 06:04:05 -0400
X-Authenticated: #14349625
Subject: Re: [patch] kprobes: optimize branch placement
From: Mike Galbraith <efault@gmx.de>
To: karim@opersys.com
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
In-Reply-To: <450CABE8.9050106@opersys.com>
References: <Pine.LNX.4.64.0609152111030.6761@scrub.home>
	 <20060915200559.GB30459@elte.hu>	<20060915202233.GA23318@Krystal>
	 <450BCAF1.2030205@sgi.com>	<20060916172419.GA15427@Krystal>
	 <20060916173552.GA7362@elte.hu>	<20060916175606.GA2837@Krystal>
	 <20060916191043.GA22558@elte.hu>	<20060916193745.GA29022@elte.hu>
	 <20060916202939.GA4520@elte.hu>	<20060916204342.GA5208@elte.hu>
	 <450C7039.20208@opersys.com> <20060916155704.ef425542.akpm@osdl.org>
	 <450CABE8.9050106@opersys.com>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 12:15:21 +0000
Message-Id: <1158495321.4691.64.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 21:59 -0400, Karim Yaghmour wrote:
> Andrew Morton wrote:
> > It's hardly rocket science - it appears that nobody has ever bothered.
> 
> Hmm, that's one explanation. The other explanation, which in my view is
> the likelier -- but I've been shown wrong before, is that most of those
> who went through that code before just didn't have Ingo's insight and
> abilities. Which goes to show what can be achieved when "interesting"
> ideas are given a hand by those having appropriate insight and
> abilities -- and, of course, what fate awaits those other ideas which
> are less so fortunate in the eyes of the talented. Praise the lord for
> the chosen ones.

(that bit after the last -- is a steaming pile of nastiness)

I don't understand your reaction.  If roles were reversed, would you not
examine the implementation?

	-Mike

