Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVA3BRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVA3BRH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 20:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVA3BRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 20:17:07 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1200 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261622AbVA3BRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 20:17:04 -0500
Date: Sun, 30 Jan 2005 02:16:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
In-Reply-To: <200501291932.31430.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0501300212170.30794@scrub.home>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
 <200501291840.12694.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300053580.30794@scrub.home>
 <200501291932.31430.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 29 Jan 2005, Dmitry Torokhov wrote:

> > That's fine, but why is it in the input menu? How do you suggest to make 
> > it selectable without selecting input and without messing the menu 
> > structure?
> 
> Well, probably split input into sections, one of the options would be
> something like "Generic Input Layer" and have evdev, mousedev, etc
> depend on it. serio will not depend on it... nor will gameport as
> I can see someone wanting gameport_raw.

That's not the point of my patch. Feel free to restructure the input menu, 
if you need help you can ask me, but is there any practically relevant 
reason, that serio_raw must not depend on INPUT right now?

bye, Roman
