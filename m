Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTLZW1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTLZW1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:27:16 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:15580 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S263851AbTLZW1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:27:15 -0500
Date: Fri, 26 Dec 2003 23:27:12 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 sound output - wierd effects
In-Reply-To: <1080000.1072475704@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0312262322580.28979@mercury.sdinet.de>
References: <1080000.1072475704@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Martin J. Bligh wrote:

> Upgraded my home desktop to 2.6.0.
> Somewhere between 2.5.63 and 2.6.0, sound got screwed up - I've confirmed
> this happens on mainline, as well as -mjb.
>
> If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
> I'll get some wierd effect for a few seconds, either static, or the track
> will mysteriously speed up or slow down. Then all is back to normal for
> another couple of minutes.
>
> Anyone else seen this, or got any clues? Else I guess I'm stuck playing
> bisection search.

I get exactly the same with kernel 2.4 and alsa, intel8x0 ac97, but did
not test alsa 1.0rc yet, which mentions "intel8x0 driver fixes, OSS PCM
emulation fixes" - perhaps these fixes help.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
