Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWE0UfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWE0UfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWE0UfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:35:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43186 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964935AbWE0UfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:35:24 -0400
Date: Sat, 27 May 2006 22:34:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] make ams work with latest kernels
Message-ID: <20060527203437.GD16612@elf.ucw.cz>
References: <1148383943.25971.2.camel@johannes> <1148465069.6723.26.camel@localhost.localdomain> <20060526173908.GA3357@ucw.cz> <1148760414.16989.59.camel@johannes.berg> <1148761919.3132.1.camel@deep-space-9.dsnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1148761919.3132.1.camel@deep-space-9.dsnet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 27-05-06 22:31:58, Stelian Pop wrote:
> Le samedi 27 mai 2006 ? 22:06 +0200, Johannes Berg a écrit :
> > On Fri, 2006-05-26 at 17:39 +0000, Pavel Machek wrote:
> > 
> > > > This driver also provides an absolute input class device, allowing
> > > > the laptop to act as a pinball machine-esque joystick.
> > > 
> > > Is it useful to have /sysfs interface when we already have same data
> > > available as joystick?
> > 
> > Might be useful if you need to turn off the "joystick" because X gets
> > confused with it. Other than that, no.
> 
> /sysfs interface also exports the 'z' coordinate, the input interface
> does not.

Can that be fixed? z coordinate should be useful for input, too.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
