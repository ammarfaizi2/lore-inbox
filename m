Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVAaN7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVAaN7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVAaN7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:59:20 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:45752 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261200AbVAaN7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:59:18 -0500
Date: Mon, 31 Jan 2005 14:59:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Takashi Iwai <tiwai@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] Kconfig: cleanup sound menu
In-Reply-To: <s5hoef5loa5.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.61.0501311458190.30794@scrub.home>
References: <Pine.LNX.4.61.0501292320430.7666@scrub.home> <s5hoef5loa5.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Jan 2005, Takashi Iwai wrote:

> > Index: linux-2.6.11/sound/core/Kconfig
> > ===================================================================
> > --- linux-2.6.11.orig/sound/core/Kconfig	2005-01-29 22:50:43.345956362 +0100
> > +++ linux-2.6.11/sound/core/Kconfig	2005-01-29 22:56:50.843656604 +0100
> > @@ -1,16 +1,20 @@
> >  # ALSA soundcard-configuration
> >  config SND_TIMER
> >  	tristate
> > +	depends on SND
> (snip)
> 
> Aren't they superfluous?
> SND_TIMER, etc, are the reverse selection entries.

Without it they break the menu structure.

bye, Roman
