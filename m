Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbTL3Qbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265838AbTL3Qbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:31:31 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:54917 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S265837AbTL3Qba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:31:30 -0500
Date: Tue, 30 Dec 2003 17:25:38 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: alsa, esd, mpg123
In-Reply-To: <20031230155358.GB23963@butterfly.hjsoft.com>
Message-ID: <Pine.LNX.4.58.0312301724470.3189@pnote.perex-int.cz>
References: <20031230155358.GB23963@butterfly.hjsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003, John M Flinchbaugh wrote:

> on my debian (unstable) laptop newly running 2.6.0, i've noticed
> an irritating tendency for music to not pause, but instead to
> try to go too fast, skipping small parts of the song (fractions
> of a second).  this results in music with regular beats sounding
> erratic.
> 
> i'm using gqmpeg -> mpg123-esd -> esd -> oss -> alsa (maestro3).
> 
> switching esd to use -tcp instead of -unix seems to alleviate
> the trouble a bit.  ogg123 playing through esd doesn't seem to
> do it as much either.
> 
> has anyone else noted this problem and tuned it away?  thanks.

Could you try this patch?

ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-12-30.patch.gz

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
