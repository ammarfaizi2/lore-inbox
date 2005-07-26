Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVG0NEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVG0NEC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVG0NCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:02:11 -0400
Received: from main.gmane.org ([80.91.229.2]:37806 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262237AbVG0NAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:00:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Zoran Dzelajlija <jelly+news@srk.fer.hr>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Wed, 27 Jul 2005 01:38:37 +0200
Organization: Mala leteca gamad
Message-ID: <20050726233837.459A.3.NOFFLE@islands.iskon.hr>
References: <20050726150837.GT3160@stusta.de> <42E6645B.30206@zabbo.net>
Reply-To: Zoran Dzelajlija <jelly+news@srk.fer.hr>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: islands.iskon.hr
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.10-skas3-v7 (i686))
Cc: linux-sound@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zab@zabbo.net> wrote:
> Adrian Bunk wrote:
> > This patch schedules obsolete OSS drivers (with ALSA drivers that 
> > support the same hardware) for removal.

> > I've Cc'ed the people listed in MAINTAINERS as being responsible for one 
> > or more of these drivers, and I've also Cc'ed the ALSA people.

> I haven't touched the maestro drivers in so long (for near-total lack of
> docs, etc.) that I can't be considered authoritative for approving it's
> removal. If people are relying on it I certainly don't know who they
> are.  In better news, Takashi should now have the pile of maestro
> hardware that I used in the first pass to help him maintain the ALSA
> driver..

The OSS maestro driver works better on my old Armada E500 laptop.  I tried
ALSA after switching to 2.6, but the computer hung with 2.6.8.1 or 2.6.10 if
I touched the volume buttons.  With OSS they just work.  The four separate
dsp devices also look kind of more useful.

Zoran

