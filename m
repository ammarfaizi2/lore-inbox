Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUAWIdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 03:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUAWIdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 03:33:36 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:36508 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S266543AbUAWIdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 03:33:33 -0500
Date: Fri, 23 Jan 2004 09:31:26 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Mark Borgerding <mark@borgerding.net>,
       LKML <linux-kernel@vger.kernel.org>, p z oooo <pzad@pobox.sk>
Subject: Re: ALSA vs. OSS
In-Reply-To: <20040122235320.GA21836@babylon.d2dc.net>
Message-ID: <Pine.LNX.4.58.0401230929230.1875@pnote.perex-int.cz>
References: <1074532714.16759.4.camel@midux> <200401201046.24172.hus@design-d.de>
 <400D2AB2.7030400@borgerding.net> <200401201513.45564.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.58.0401201615480.2010@pnote.perex-int.cz>
 <20040122235320.GA21836@babylon.d2dc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, Zephaniah E. Hull wrote:

> On Tue, Jan 20, 2004 at 04:19:29PM +0100, Jaroslav Kysela wrote:
> > On Tue, 20 Jan 2004, Alistair John Strachan wrote:
> > > If ALSA does or could support working with the programmable dsp, I'd be happy 
> > > to switch to it. Right now my "deprecated" SBLive! OSS drivers output higher 
> > > quality audio.
> > 
> > We don't have user space tools to update DSP code although our emu10k1
> > driver is capable to do it. Sure, we are doing things differently than OSS
> > driver so you cannot simply use the OSS utilities.
> > 
> > Perhaps, time to help us?
> 
> Is there any documentation on the interface for uploading new DSP code
> to the emu10k1?
> 
> Such would be /very/ useful for the task of writing tools to do the job.

There is a preliminary emu10k* loader:

http://ld10k1.sourceforge.net/

The author is also reachable at <pzad@pobox.sk>.

The whole API is in linux/include/sound/emu10k1.h (look at bottom).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
