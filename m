Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWFGIpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWFGIpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWFGIpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:45:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65225 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750935AbWFGIpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:45:40 -0400
Date: Wed, 7 Jun 2006 10:44:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Message-ID: <20060607084455.GA7399@elf.ucw.cz>
References: <20060604135011.decdc7c9.akpm@osdl.org> <448366FB.1070407@zytor.com> <20060606152041.GA5427@ucw.cz> <200606062256.55472.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606062256.55472.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > > The original idea was due Al Viro; obviously, the 
> > > implementation is mostly mine.
> > > 
> > > It is of course my hope that this will be used for more 
> > > than just plain initialization code, but that in itself 
> > > is a significant step, and one has to start somewhere.
> > 
> > It allows me to unify swsusp & uswsusp into one in future, for
> > example, reducing code duplication.
> 
> [cough] How distant is the future you're referring to?

Year or two, I believe. Actually it is not as much as "unify swsusp &
uswsusp" as "drop kernel/power/swap.c" and possibly put parts of
uswsusp into initial userland so that user do not notice it was
dropped from kernel.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
