Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWAVPeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWAVPeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 10:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWAVPeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 10:34:10 -0500
Received: from gate.perex.cz ([85.132.177.35]:27564 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932236AbWAVPeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 10:34:09 -0500
Date: Sun, 22 Jan 2006 16:34:07 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net,
       Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
 approach
In-Reply-To: <Pine.LNX.4.61.0601210958010.21704@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0601221632250.9516@tm8103.perex-int.cz>
References: <20060119174600.GT19398@stusta.de> <s5hmzhr7xsr.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601201729370.10065@yvahk01.tjqt.qr> <200601201844.29873.pzad@pobox.sk>
 <Pine.LNX.4.61.0601210958010.21704@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jan 2006, Jan Engelhardt wrote:

> >> Ah, so http://alphagate.hopto.org/quad_dsp/ which I had created
> >> is The Right Thing?
> >
> >This will work for your card, but not for emu10k1.
> 
> Does emu10k1 provide no adsp, how does it work?

It supports multi-open and then the application can set channel routing 
specific per file descriptor (alsa-lib does this setup for user offering 
only abstract device names like front, rear, center_lfe, surround40, 
surround51 etc.).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
