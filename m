Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTE1WBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTE1WBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:01:14 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:21651 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261249AbTE1WBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:01:12 -0400
Date: Thu, 29 May 2003 00:14:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
Message-ID: <20030528221414.GC667@elf.ucw.cz>
References: <200305272104.05802.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271611410.9487@freak.distro.conectiva> <200305272118.29554.m.c.p@wolk-project.de> <200305272127.53355.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271631020.9487@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305271631020.9487@freak.distro.conectiva>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Not suitable for -rc. Btw, -rc5 is already at bkbits.net.
> > BTW: This breaks _nothing_. It _fixes_ an annoying bug! ;)
> 
> You're not completly sure it doesnt break nothing. MM/VM can be reallly
> subtle and nasty at times.

OOM killer is nor subtle nor nasty. And not normally used. That patch
really should be safe.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
