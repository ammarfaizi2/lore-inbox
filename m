Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVGIScj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVGIScj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVGISca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:32:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37058 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261682AbVGIScQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:32:16 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: azarah@nosferatu.za.org, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <1120932991.6488.64.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan>  <1120932991.6488.64.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 20:31:55 +0200
Message-Id: <1120933916.3176.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 14:16 -0400, Lee Revell wrote:
> On Sat, 2005-07-09 at 19:08 +0200, Martin Schlemmer wrote:
> > On Fri, 2005-07-08 at 14:59 -0700, Andrew Morton wrote:
> > > Chris Wedgwood <cw@f00f.org> wrote:
> > 
> > > > WHAT?
> > > > 
> > > > The previous value here i386 is 1000 --- so why is the default 250.
> > > 
> > > Because 1000 is too high.
> > > 
> > 
> > What happened to 300 as default, as that is divisible by both 50 and 60
> > (or something like that) ?
> 
> I still think you're absolutely insane to change the default in the
> middle of a stable kernel series.  People WILL complain about it.

why?

it's a config option. Some distros ship 100 already, others 1000, again
others will do 250. What does it matter?
(Although I still prefer 300 over 250 due to the 50/60 thing)

This is not a userspace visible thing really with few exceptions, and
well people can select the one they want, right?


