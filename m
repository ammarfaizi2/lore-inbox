Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263819AbVBDOuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbVBDOuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbVBDOuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:50:09 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13522 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266072AbVBDOrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:47:19 -0500
Date: Fri, 4 Feb 2005 15:47:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: dtor_core@ameritech.net
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
In-Reply-To: <d120d50005020406274bc0d847@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502041544490.6118@scrub.home>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> 
 <200501292307.55193.dtor_core@ameritech.net>  <Pine.LNX.4.61.0501301639171.30794@scrub.home>
  <200501301839.37548.dtor_core@ameritech.net>  <20050204131436.GC10424@ucw.cz>
  <Pine.LNX.4.61.0502041511540.6118@scrub.home> <d120d50005020406274bc0d847@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Feb 2005, Dmitry Torokhov wrote:

> The "generic input layer" submenu is comparable to SCSI or ALSA and
> has similar menu structure with userland interfaces on top and drivers
> below them. Hardware ports (serio, gameport) "live" outside of generic
> input layer and are shown there so they are easier to find.

That's an implementation detail you don't really want to let the normal 
user to know. It's already bad enough that simple keyboard support 
requires to select two config options.

bye, Roman
