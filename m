Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263160AbVG3ULi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbVG3ULi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbVG3UJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:09:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54732 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263150AbVG3UHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:07:00 -0400
Date: Sat, 30 Jul 2005 22:06:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.net>, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org
Subject: Re: dpm_runtime_suspend and _resume()
Message-ID: <20050730200653.GC9188@elf.ucw.cz>
References: <20050730142502.GA4065@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730142502.GA4065@isilmar.linta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> dpm_runtime_suspend and _resume() would be quite useful for some PCMCIA
> tasks. However, they are only exported in drivers/base/power/power.h. Any
> objection to moving it to include/linux/pm.h ? Any plans to break the
> functionality these functions provide?

Well, given that runtime suspend functions are parts of unfinished
runtime-suspend infrastructure... what do you want to use them for?

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
