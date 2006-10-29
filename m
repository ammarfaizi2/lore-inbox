Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWJ2JUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWJ2JUd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWJ2JUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:20:33 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:7827 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932126AbWJ2JUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:20:32 -0500
Message-ID: <4544725E.4050107@drzeus.cx>
Date: Sun, 29 Oct 2006 10:20:30 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.19-rc2-mm2] oops removing sd card
References: <20061029034359.25131.qmail@web36709.mail.mud.yahoo.com>
In-Reply-To: <20061029034359.25131.qmail@web36709.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> I know that this is unfortunate, but I, currently, don't have an ability to put 2.6.19 kernel on a
> machine with ti controller. I have not seen this problem on 2.6.18, so I'm out of ideas.
> 

So put together some patches that will help you figure out the problem
via Fabio. Tracking an oops isn't usually that difficult (it's usually
some bogus pointer somewhere). Just sprinkle BUG_ON():s and printk:s all
over the place until you can pinpoint the offending pointer.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
