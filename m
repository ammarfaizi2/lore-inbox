Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVAQP2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVAQP2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVAQP2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:28:23 -0500
Received: from gprs215-94.eurotel.cz ([160.218.215.94]:20878 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261746AbVAQP2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:28:20 -0500
Date: Mon, 17 Jan 2005 16:27:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] i386/power/cpu.c: remove three unused variables
Message-ID: <20050117152727.GB1379@elf.ucw.cz>
References: <20050116081110.GI4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116081110.GI4274@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The patch below removes three unused variables.
> 
> Please check whether this patch is correct, or whether the variables 
> should have been used.

The patch is probably correct (assuming %eax, %ecx and %edx are
caller-saved on i386. [Honza, please confirm... I do not know i386
calling convention by heart.]
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
