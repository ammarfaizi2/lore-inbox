Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWAJAvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWAJAvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWAJAvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:51:13 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:29555 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1750976AbWAJAvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:51:12 -0500
Date: Tue, 10 Jan 2006 02:48:35 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: John Rigg <ad@sound-man.co.uk>
Cc: David Lang <dlang@digitalinsight.com>,
       =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060109232043.GA5013@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0601100212290.26233@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de>
 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de>
 <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
 <20060109232043.GA5013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, John Rigg wrote:

> Yes, but the CPU has plenty of other work to do. The sound cards that
> would be worst affected by this are the big RME cards (non-interleaved) and
> multiple ice1712 cards (non-interleaved blocks of interleaved data),
ice1712 uses normal interleaving. There are no "non-interleaved blocks".

> which AFAIK are the only cards capable of handling serious professional audio.
> This could represent 48 or more channels of 96kHz audio, which
> doesn't leave a lot of spare CPU capacity for running X, for example.

This is true only if you run the system at full 100% load before the 
conversions. But in real life you cannot do this anyway. You have to use 
a CPU that has lot of spare power. Otherwise anything unpredictable will 
make things to fail.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
