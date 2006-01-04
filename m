Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWADOsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWADOsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWADOsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:48:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51619 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030221AbWADOr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:47:58 -0500
Date: Wed, 4 Jan 2006 15:46:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Takashi Iwai <tiwai@suse.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Tomasz Torcz <zdzichu@irc.pl>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <s5hpsn8md1j.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
References: <20050726150837.GT3160@stusta.de> <200601031522.06898.s0348365@sms.ed.ac.uk>
 <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk>
 <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de>
 <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de>
 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
 <20060103215654.GH3831@stusta.de> <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com>
 <s5hpsn8md1j.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Still would be nice if users of ALSA who have the OSS backwards compat
>> enabled would thus also get transparent software mixing for all apps
>> using the OSS API.
>> not crucial, that's not what I'm saying, just nice if it would be possible.
>
>Technicall it's trivial to implement the soft-mixing in the kernel.
>The question is whether it's the right implementation.
>We have a user-space softmix for ALSA, and aoss wrapper for OSS using
>it.  (I know aoss still has some problems that should be fixed,
>though.)
>
Software mixing in the kernel is like FPU ops in the kernel...



Jan Engelhardt
-- 
