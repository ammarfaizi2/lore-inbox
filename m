Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVA3DXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVA3DXN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 22:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVA3DXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 22:23:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22704 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261639AbVA3DWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 22:22:52 -0500
Date: Sun, 30 Jan 2005 04:22:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
In-Reply-To: <200501292127.29418.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0501300409300.6118@scrub.home>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
 <200501291932.31430.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300212170.30794@scrub.home>
 <200501292127.29418.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 29 Jan 2005, Dmitry Torokhov wrote:

> Well, with the current Kconfig I can de-select INPUT and still select
> serio and serio_raw and access my AUX port via /dev/psaux. I don't know
> if anyone would really do it, but why not?
> 
> Btw, what was the point of your patch?

See the subject. The current input Kconfig menu is already quite complex 
for a lot of people, we don't have to confuse them further with a chaotic 
menu structure. I only did the minimal fixes to get it into proper shape 
with an acceptable compromise. Feel free to take it from here to also make 
it technically correct.

bye, Roman
