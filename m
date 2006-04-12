Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWDLLRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWDLLRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 07:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWDLLRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 07:17:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37571 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932157AbWDLLRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 07:17:35 -0400
Date: Wed, 12 Apr 2006 13:16:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] generic clocksource updates
In-Reply-To: <1144449655.5925.260.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604121308160.32445@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home> 
 <1144317972.5344.681.camel@localhost.localdomain>  <Pine.LNX.4.64.0604062048130.17704@scrub.home>
  <1144351944.5925.23.camel@localhost.localdomain>  <Pine.LNX.4.64.0604072239110.32445@scrub.home>
 <1144449655.5925.260.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Apr 2006, Thomas Gleixner wrote:

> > Then please explain these requirements.
> 
> I explained them very clear in my original post:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114431804702870&w=2
> 
> > This field shouldn't have been added in first place, I guess I managed to 
> > confuse John when I talked about handling of continuous vs. tick based 
> > clocks.
> 
> I appreciate your responsibility, but the is_continous field was
> introduced on my request because I did not want to rely on (rating > X)
> to decide whether I can safely switch to high resolution timer mode or
> not.

What you didn't explain is why exactly makes this field a difference. 
Right now one can only read the clocksource, so why should it make a 
difference how the time is generated?

> I really do not understand, why you claim to be the ultimate authority
> to decide whats right and wrong in this area. Can you please shed some
> light on my agnostic mind with some _real_ explanation why you can claim
> to have the authority to decide whats needed and whats not needed ?
> 
> "Currently this field isn't needed and as soon we have a need ....".
> ----------------------------------------------^^^^
> 
> I guess http://en.wikipedia.org/wiki/Pluralis_Majestatis is the right
> place for me until you start to explain.

Out of curiosity: what kind of response do you expect to such crap?

(To understand how ridiculous this is, one only has to know whose time(r) 
patches get dropped by Andrew like hot potatoes.)

> > Currently no user should even care about this, it's an 
> > implementation detail of the clock.
> 
> Right. Even if no user cares about this right now, nevertheless
> forseeing the requirements of the near future is the finer art of
> engineering. Especially if there is existing experience, which shows
> that it is necessary.

I do respect your experience, but you also have to show it.

bye, Roman
