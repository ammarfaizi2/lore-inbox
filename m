Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTJ2Ia5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 03:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTJ2Ia5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 03:30:57 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:63689 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261931AbTJ2Iaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 03:30:55 -0500
Date: Wed, 29 Oct 2003 09:30:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031029083040.GA18135@ucw.cz>
References: <20031027140217.GA1065@averell> <20031028035625.GB20145@rivenstone.net> <20031028094709.GA4325@ucw.cz> <200310290136.06439.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310290136.06439.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 01:36:04AM -0500, Dmitry Torokhov wrote:

> On Tuesday 28 October 2003 04:47 am, Vojtech Pavlik wrote:
> > > >     I need this patch to use the scroll wheel on my Logitech mouse
> > > > with my Belkin KVM switch in 2.6. This patch was in -mm for a while
> > > > before some changes there broke the diff, and I got some mail from
> > > > people who said it was helpful.  I didn't hear about any problems.
> > > >
> > > >     Linus, will you please consider applying it?
> >
> > Plase not in this shape. I don't want yet another option to the driver.
> > Dmitry said he'll whip up a patch that with a single option can limit
> > the maximum protocol of the PS/2 mouse to either PS/2, IMPS/2 or
> > ImExPS/2, possibly more, "psmouse_proto=". That's a better solution.
> >
> 
> Here it is... New parameter psmouse_proto={bare|imps|exps}. I don't think
> we should bother with providing options for the rest of the protocols as
> these 3 are most generic ones.
> 
> I marked psmouse_noext deprecated and psmouse will emit a warning if it
> is used, if you think we can still remove it completely at this time just
> let me know.
> 
> I also changed the parameter processing to module_param as it is much
> easier.

Thanks!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
