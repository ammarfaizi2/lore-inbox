Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTGANDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 09:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTGANDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 09:03:42 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:40975 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262361AbTGANDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 09:03:40 -0400
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200307012204.47605.kernel@kolivas.org>
References: <200307010029.19423.kernel@kolivas.org>
	 <200307011931.24586.kernel@kolivas.org>
	 <1057060831.603.6.camel@teapot.felipe-alfaro.com>
	 <200307012204.47605.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1057065479.1171.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 01 Jul 2003 15:17:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 14:04, Con Kolivas wrote:

> >When I say "X feels jerky", I mean that I can notice the scheduler is
> >not giving the X server enough CPU cycles (I mean, a continuous,
> >smaller, but more frequent CPU timeslice) to perform window movement and
> >redrawing fast enough to get ~25fps. Also, I don't think it's related to
> >the video card. The combo patch I did with Mike's + Ingo's enhacements
> >works beautifully for me.
> 
> Actually just the bastardised Ingo patch will do that on it's own. However 
> that's never going to be incorporated.

So, I guess we won't have the option to choose between different CPU
schedulers (desktop or server, for example), like we have in -mm kernels
with IO schedulers (deadline or anticipatory).

Seriously talking, I prefer to have the best performance in my server
boxes, but for my laptop, I prefer shorter timeslices, lower peformance
and better turnaround times and a wiser CPU scheduler. Just my two
cents.

It's sad to say but I feel the vanilla 2.5 CPU scheduler doesn't match
my end-user preferences :-(

