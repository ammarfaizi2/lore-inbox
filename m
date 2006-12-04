Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937371AbWLDUXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937371AbWLDUXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937370AbWLDUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:23:22 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:39097 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937371AbWLDUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:23:21 -0500
Message-ID: <457483B5.8060205@drzeus.cx>
Date: Mon, 04 Dec 2006 21:23:17 +0100
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
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx> <45746CD3.1000604@indt.org.br>
In-Reply-To: <45746CD3.1000604@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
>
> Actually they represent the bits regarding the modes and it is used
> when we
> have to send the LOCK/UNLOCK mode on the command data block, according
> to the MMC Spec.
> If you take a look at mmc_lock_unlock function, we use those modes to
> set the right bit
> when composing the command data block.
> This definition makes the code more legible and simple.

In that case you need to change the code to make sure it is clear that
it is bits and not values. Also, your definition for
MMC_LOCK_MODE_UNLOCK is wrong.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

