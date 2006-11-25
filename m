Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757895AbWKYIi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895AbWKYIi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757896AbWKYIi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:38:59 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:28567 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1757895AbWKYIi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:38:58 -0500
Message-ID: <45680128.5000506@drzeus.cx>
Date: Sat, 25 Nov 2006 09:39:04 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_ignore_locked.diff
References: <45646330.9010402@indt.org.br>
In-Reply-To: <45646330.9010402@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> When a card is locked, only commands from the "basic" and "lock card"
> classes
> are accepted. To be able to use the other commands, the card must be
> unlocked
> first.
>
> This patch prevents the device drivers from trying to run privileged
> class
> commands on locked MMC cards, which will fail anyway.
>

You still need to change the commit message, but otherwise the patch
looks ok.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

