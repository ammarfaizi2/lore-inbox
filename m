Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUESTeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUESTeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUESTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 15:34:21 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:50960 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264263AbUESTeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 15:34:20 -0400
Date: Wed, 19 May 2004 20:34:14 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: David Eger <eger-dated-1085563931.b5f459@theboonies.us>
cc: akpm@osdl.org,
       Linux Frame Buffer Dev 
	<linux-fbdev-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] FB accel capabilities patch
In-Reply-To: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
Message-ID: <Pine.LNX.4.44.0405192026290.28783-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A month or two ago I noticed that the framebuffer console driver doesn't
> know to do proper framebuffer acceleration in Linux 2.6;  I've implemented
> a solution Geert suggested where each framebuffer driver advertizes its 
> hardware capabilities via fb_info->flags.  Please apply to -mm so I can 
> get wider testing.
> 
> The patches are at:
> 
> http://www.yak.net/random/fbdev-patches/accel-cap-take2/relative2mainline/
> 
> The core of these patches is enabling the use of the following flags:
> 
> +/* FBIF = FB_Info.Flags */
> +#define FBIF_MODULE		0x0001	/* Low-level driver is a module */

Ug. You changed that. Could that remain the same. 

I have a patch coming that fixes the mode setting. It changes alot of the 
core fbcon.c so I will apply your patch to the fbdev-2.5 tree. 


