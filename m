Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVBFJgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVBFJgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 04:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbVBFJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 04:36:47 -0500
Received: from gprs215-220.eurotel.cz ([160.218.215.220]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261794AbVBFJgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 04:36:37 -0500
Date: Sun, 6 Feb 2005 10:27:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Message-ID: <20050206092731.GA3869@elf.ucw.cz>
References: <200502051448.57492.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502051448.57492.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The patch below attempts to better handle situation when psmouse interrupt
> is delayed for more than 0.5 sec by requesting a resend. This will allow
> properly synchronize with the beginning of the packet as mouse is supposed
> to resend entire package.

+                * This is second error in a row. If mouse was itialized - attempt
+                * to rconnect, otherwise just signal failure.

Tooo many typso in on coment?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
