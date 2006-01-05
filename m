Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWAEPdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWAEPdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWAEPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:33:47 -0500
Received: from gate.perex.cz ([85.132.177.35]:58034 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932082AbWAEPdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:33:45 -0500
Date: Thu, 5 Jan 2006 16:33:44 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Olivier Galibert <galibert@pobox.com>
Cc: Heikki Orsila <shd@modeemi.cs.tut.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060105145101.GB28611@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0601051631260.10350@tm8103.perex-int.cz>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
 <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
 <20060105145101.GB28611@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Olivier Galibert wrote:

> - "A small demo which sends a simple sinusoidal wave to the speakers"
>   requiring close to 900 lines is demented.  That's the size of
>   glxgears.c, with 50% of that one being printer support.  A complete
>   smartflow example getting a sound stream on the network and playing
>   it with oss takes 160 lines, with 20 lines of copyright-ish at the
>   start.  The actual sound part of that is _30_ lines.

The pcm.c file shows you 7 available methods how you can send audio data 
to alsa-lib. It's complete example. If you remove the parsing command 
line, sine generation, error handling, you'll end with few lines too.

> - Error and state handling after writei changes depending on the call.
>   We're supposed to guess which one is correct?
> 
> Make simple things simple, guys.

Yes, we should stay with simple 1.0 linux kernel. Anyway, we're taking all 
points from this discussion.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
