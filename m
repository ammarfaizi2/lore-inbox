Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbULYWYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbULYWYo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 17:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbULYWYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 17:24:44 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:62850 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261581AbULYWYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 17:24:43 -0500
Date: Sat, 25 Dec 2004 23:24:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] time sliced cfq ver18
Message-ID: <20041225222431.GA27315@elf.ucw.cz>
References: <20041221144046.GN2773@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221144046.GN2773@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've finished version 18 of the time sliced cfq io scheduler. The
> highlights of this io scheduler are (in no particular order):
> 
> - It gives each process doing io access to the disk exclusively for a
>   defined period of time. This is known as the disk slice, hence the
>   name time sliced cfq. Most processes have at least some locality
> on

Wow, nice. Now that we have nice and ionice, can we have netnice too?
netnice rsync .... would  be very usefull :-).
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
