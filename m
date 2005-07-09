Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVGISQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVGISQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVGISQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:16:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6054 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261659AbVGISQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:16:33 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: azarah@nosferatu.za.org
Cc: Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <1120928891.17184.10.camel@lycan.lan>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 14:16:31 -0400
Message-Id: <1120932991.6488.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 19:08 +0200, Martin Schlemmer wrote:
> On Fri, 2005-07-08 at 14:59 -0700, Andrew Morton wrote:
> > Chris Wedgwood <cw@f00f.org> wrote:
> 
> > > WHAT?
> > > 
> > > The previous value here i386 is 1000 --- so why is the default 250.
> > 
> > Because 1000 is too high.
> > 
> 
> What happened to 300 as default, as that is divisible by both 50 and 60
> (or something like that) ?

I still think you're absolutely insane to change the default in the
middle of a stable kernel series.  People WILL complain about it.

Lee

