Return-Path: <linux-kernel-owner+w=401wt.eu-S936583AbWLIJYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936583AbWLIJYj (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936589AbWLIJYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:24:39 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:53484 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936583AbWLIJYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:24:38 -0500
Date: Sat, 9 Dec 2006 10:22:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Ian E. Morgan" <penguin.wrangler@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, emu10k1-devel@lists.sourceforge.net
Subject: Re: Loud POP from sound system during module init w/ 2.6.19
In-Reply-To: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
References: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 8 2006 13:53, Ian E. Morgan wrote:
>Subject: Loud POP from sound system during module init w/ 2.6.19

What kernel did you have before?

What you see is the same I am experiencing on every boot - when the sound
module is loaded, udev loads the previous volume settings. The volume settings
are normal for me, but I guess the instant jump from 0-70% (for Master) and
0-61% (for PCM) is not taken too heartly by the soundcard.

> Since upgrading to 2.6.19, two of my boxes (one workstation, one
> notebook) started making a very loud (and scary) POP from the sound
> system when the alsa modules are loaded. Unloading and reloading the
> modules will generate another pop.
>
> Anybody else seeing this behaviour and know how to stop it?
>

	-`J'
-- 
