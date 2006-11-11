Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946950AbWKKFJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946950AbWKKFJc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 00:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946974AbWKKFJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 00:09:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946950AbWKKFJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 00:09:32 -0500
Date: Fri, 10 Nov 2006 21:09:17 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-ID: <20061110210917.2bd568ab@localhost.localdomain>
In-Reply-To: <200611110715.49343.a1426z@gawab.com>
References: <200611090757.48744.a1426z@gawab.com>
	<200611110022.52304.a1426z@gawab.com>
	<20061110133101.4e6cddd3@freekitty>
	<200611110715.49343.a1426z@gawab.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 07:15:49 +0300
Al Boldi <a1426z@gawab.com> wrote:

> Stephen Hemminger wrote:
> > Al Boldi <a1426z@gawab.com> wrote:
> > > Arjan van de Ven wrote:
> > > > > The problem is not just simple bugs that surface, it's deeper than
> > > > > that. Deep structural problems is what plagues 2.6.
> > > > >
> > > > > Only a focused model may deal with such problems.
> > > >
> > > > can you at least provide a list of such structural problems?
> > > > In fact, why don't you collect them and mail them out (bi)weekly...
> > > > that may already do wonders.
> > > > Look at what Adrian is doing with the regressions; although the
> > > > response isn't 100% people DO pay attention to it.... so maybe if you
> > > > post a "structural problems list" people will actually start working
> > > > on things.. (and of course you can help too ;)
> > >
> > > Ok, things like OOM, scheduling, and block-io.
> >
> > If you want stability don't change these.  But if you think you
> > have better heuristics propose them for discussion.
> 
> I don't think there is a lack of heuristics, nor is there a lack of 
> discussion.  What is needed, is a realization of the problem.
> 
> IOW, respective tree-owners need to come to a realization of the state of 
> their trees, problem or not.  If it has a problem, that problem needs to be 
> fixed or backed out of stable and moved into dev.
> 
> > > net looks ok, although I would suggest a redesign for 3.0.
> >
> > Facts, no vague pronouncements please.
> 
> I meant structural OSI compliance.

Read the book "Network Algorithmics"; it has a clear discussion
of why building your stack like the protocol specification
is a bad idea.
> 
