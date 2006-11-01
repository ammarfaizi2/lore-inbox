Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946868AbWKANVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946868AbWKANVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946870AbWKANVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:21:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27275 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946868AbWKANVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:21:05 -0500
Date: Wed, 1 Nov 2006 14:20:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc4-mm1: noidlehz problems
Message-ID: <20061101132052.GA2567@elf.ucw.cz>
References: <20061101122319.GA13056@elf.ucw.cz> <1162386177.23744.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162386177.23744.17.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-11-01 14:02:57, Arjan van de Ven wrote:
> On Wed, 2006-11-01 at 13:23 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > First, it would be nice if we had someone listed as a maintainer of
> > noidlehz stuff...
> > 
> > Then... I'm getting strange messages from noidlehz each time I
> > unplug/replug AC power (perhaps due to interrupt latency?).
> 
> there probably is a different story going on.
> When you unplug/replug AC power, several bioses change the meaning of
> the software C-states in your system.
> (there is a mapping between software visible C states and the hardware
> C-states)

Yep, my notebook is one of such machines, so your theory looks very plausible.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
