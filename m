Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbUKCWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUKCWfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKCWYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:24:19 -0500
Received: from mx.inch.com ([216.223.198.27]:58118 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261925AbUKCWMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:12:10 -0500
Date: Wed, 3 Nov 2004 17:12:05 -0500 (EST)
From: John McGowan <jmcgowan@inch.com>
To: Dave Airlie <airlied@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9: i810 video
In-Reply-To: <21d7e99704110313583cccde5f@mail.gmail.com>
Message-ID: <20041103170945.V81684@shell.inch.com>
References: <20041102215308.GA3579@localhost.localdomain>
 <21d7e99704110313583cccde5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Dave Airlie wrote:

> > In kernel 2.6.9 it seems that the Intel i810 video driver is useless (junk
> > on the screen ... lockup) and one can no longer compile alsa-lib-1.0.6 from
> > the source at alsa-project.org. That's as far as I got before I now have to
> > recompile the working 2.6.7 (if only gimp worked with it ...).
> >
>
> Is that the i810 framebuffer? or the i810 drm?

I tried compiling the kernel without the intel810 framebuffer support
and still, it seems that something writes all over video memory (I did not
try using the fbdev driver in Xorg when I was trying to get 2.6.9 working,
just its i180 driver).

Then again, in kernel 2.6.7 I have no problem.

Regards from:

    John McGowan  |  jmcgowan@inch.com                [Internet Channel]
                  |  jmcgowan@coin.org                [COIN]
    --------------+-----------------------------------------------------
