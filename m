Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUAUCi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 21:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUAUCi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 21:38:29 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:35458 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S261539AbUAUCi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 21:38:28 -0500
Date: Wed, 21 Jan 2004 02:40:38 +0000
From: Jonathan Boler <j.m.boler@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA vs. OSS
Message-Id: <20040121024038.5147bc92.j.m.boler@sms.ed.ac.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jan 20 2004 - 10:13:06 EST - Alistair John Strachan Wrote:

> The OSS userspace utilities, however, program the EMU10k1 dsp with a very nice
> tone control patch that produces a very high quality control with no
> clipping.

The OSS utilities for emu10k1 are very nice but no doubt they will eventually make their way to alsa.

> 
> If ALSA does or could support working with the programmable dsp, I'd be happy
> to switch to it. Right now my "deprecated" SBLive! OSS drivers output higher
> quality audio.

As far as I can see from the alsa-devel lists, there have been patches to ensure sound is routed through the high quality components of Audigy cards to ensure the best sound quality and consistent sound levels through all channels. I definately noticed an improvement over the OSS Audigy driver which I used for over a year.

Maybe this is a SBLive specific problem ? Buy an Audigy :) Everything I've tried to do has worked perfectly with ALSA: 5.1 playback, digital out, AC3/DTS passthrough, recording from mic/line-in etc.

Jonathan
