Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVEOGYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVEOGYx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 02:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVEOGYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 02:24:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46271 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261493AbVEOGYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 02:24:49 -0400
Date: Sun, 15 May 2005 08:22:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Petr Baudis <pasky@ucw.cz>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4e vs git network pull
Message-ID: <20050515062243.GA22021@elte.hu>
References: <20050512094406.GZ5914@waste.org> <20050512182340.GA324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512182340.GA324@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

> > Mercurial is also much smarter than rsync at determining what
> > outstanding changesets exist. Here's an empty pull as a demonstration:
> > 
> >  $ time hg merge hg://selenic.com/linux-hg/
> >  retrieving changegroup
> > 
> >  real    0m0.363s
> >  user    0m0.083s
> >  sys     0m0.007s
> > 
> > That's a single http request and a one line response.
> 
> So, what about comparing it with something comparable, say git pull 
> over HTTP? :-)

Matt, did you get around to do such a comparison?

	Ingo
