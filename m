Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754009AbWKRVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbWKRVlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbWKRVlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:41:55 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:36758 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1754174AbWKRVlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:41:52 -0500
Message-ID: <455F7E2A.60009@drzeus.cx>
Date: Sat, 18 Nov 2006 22:42:02 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Anderson Briglia <anderson.briglia@indt.org.br>,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: Re: [patch 0/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
References: <455DB1FB.1060403@indt.org.br> <200611181117.54242.david-b@pacbell.net>
In-Reply-To: <200611181117.54242.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> I thought the MMC vendors expected to see the actual user-typed
> password get SHA1-hashed into a value which would take up the whole
> buffer?  In general that's a good idea, since it promotes use of
> longer passphrases (more information) over short ones (easy2crack).
>   

This sounds like policy though, so it is something user space should
concern itself with. We should just provide the infrastructure.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

