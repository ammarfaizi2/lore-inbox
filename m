Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbULMKnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbULMKnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 05:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbULMKnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 05:43:39 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:40581 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262219AbULMKne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 05:43:34 -0500
Date: Mon, 13 Dec 2004 11:43:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213104321.GB7340@elf.ucw.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234256.GK6272@elf.ucw.cz> <cone.1102896588.31702.10669.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1102896588.31702.10669.502@pc.kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Actually, I measured about 1W power savings with HZ=100. That's about
> >as much as spindown of disk saves...
> 
> How does the popular proprietary operating system cope with this? My 
> understanding is they run 1000Hz yet they have good power saving and quiet 
> capacitors. Presumably they do a lot less per timer tick?

Doing lot less per timer tick is not going to help much... You cpu
needs to awaken, anyway, and awaking of CPU takes lot of time and lot
of power, and is probably going to take way more power than execution
of timer interrupt.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
