Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVA2X5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVA2X5D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVA2X5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:57:03 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:50351 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261611AbVA2X44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:56:56 -0500
Date: Sun, 30 Jan 2005 00:56:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
In-Reply-To: <200501291840.12694.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.61.0501300053580.30794@scrub.home>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
 <200501291750.50886.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300008381.6118@scrub.home>
 <200501291840.12694.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 29 Jan 2005, Dmitry Torokhov wrote:

> I can assure you that serio_raw driver _does not_ use input system - it is
> implementation of pre 2.6 /dev/psaux interface giving you access to raw AUX
> data. It was written so we can still use PS/2 devices for which we don't have
> proper in-kernel driver but have working userspace solution. It completely
> bypasses input layer.

That's fine, but why is it in the input menu? How do you suggest to make 
it selectable without selecting input and without messing the menu 
structure?

bye, Roman
