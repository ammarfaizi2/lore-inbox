Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbTFWSkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbTFWSkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:40:21 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:31245 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266090AbTFWSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:40:19 -0400
Subject: Re: [PATCH] 2.5.72-mm3 O(1) interactivity enhancements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200306240015.23613.kernel@kolivas.org>
References: <1056368505.746.4.camel@teapot.felipe-alfaro.com>
	 <200306240015.23613.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1056394444.587.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 20:54:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 16:15, Con Kolivas wrote:

> For those who aren't familiar, you've utilised the secret desktop weapon:
> 
> +		if (!(p->time_slice % MIN_TIMESLICE) &&
> 
> This is not how Ingo intended it. This is my desktop bastardising of the 
> patch. It was originally about 50ms (timeslice granularity). This changes it 
> to 10ms which means all running tasks round robin every 10ms - this is what I 
> use in -ck and is great for a desktop but most probably of detriment 
> elsewhere. Having said that, it does nice things to desktops :-)

I lost the track to Ingo's patch sometime ago, so I borrowed it from
your latest patchset ;-) It does really nice things on desktops. It
brings 2.5 to a new life on my 700Mhz laptop.

What impact would have increasing MIN_TIMESLICE from 10 to, let's say,
50?

Thanks!

