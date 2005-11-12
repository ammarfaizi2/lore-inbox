Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVKLDC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVKLDC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 22:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVKLDC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 22:02:29 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17552 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751104AbVKLDC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 22:02:28 -0500
Subject: Re: CM8738 audio hampering while playing video on G450 PCI graphic
	card
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511120241.54383.mark.hurenkamp@xs4all.nl>
References: <200511120241.54383.mark.hurenkamp@xs4all.nl>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 22:00:43 -0500
Message-Id: <1131764444.11279.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 02:41 +0100, Mark Hurenkamp wrote:
> Now whenever there's a lot of activety (like scrolling down when I'm
> browsing on a news site like slashdot, or playing video) on the G450 (both in 
> accelerated mode, as well as in unaccelerated framebuffer mode), the audio 
> (onboard CMedia) starts to hamper. This happens regardless wether I'm using
> alsa, or oss. (using mplayer to play an mp3, but also with DivX movies
> the same problem occurs).

Sounds like a "singing capacitor".  Check the LKML archives.

It's fundamentally a hardware problem caused by vendor greed which leads
them to cheap out on components, compounded by only testing on Windows
which has a dynamic timer tick.

This can often be worked around by setting HZ=100 but you'll take a
performance and timing granularity hit.

Lee

