Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271025AbTGVUFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271027AbTGVUFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:05:25 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:55303 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S271025AbTGVUFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:05:20 -0400
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030722193917.GA14669@localhost>
References: <bUil.2D8.11@gated-at.bofh.it>
	 <pan.2003.07.22.15.14.44.457281@mtco.com>
	 <20030722180442.6c116e1c.martin.zwickel@technotrend.de>
	 <1058899302.733.1.camel@teapot.felipe-alfaro.com>
	 <20030722193917.GA14669@localhost>
Content-Type: text/plain
Message-Id: <1058905222.731.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 22:20:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-22 at 21:39, Jose Luis Domingo Lopez wrote:
> > Could you please test 2.6.0-test1-mm2? It includes some scheduler fixes
> > from Con Kolivas that will help in reducing or eliminating your
> > starvation issues.
> > 
> I was having the same jumpy mouse behaviuor with 2.6.0-test1, and on an
> otherwise idle Pentium III at 600 MHz box, scrolling a very simple HTML
> page in Mozilla makes xmms skip audio.
> 
> Then I tried 2.6.0-test1-mm2, and several things happened: now scrolling
> an HTML page in Mozilla seems not to affect MP3 playback with XMMS, but
> this is the only possitive effect. Focusing windows raises them way
> slower than in 2.6.0-test1, scheduler starvation is constant (just try
> to do something like going to another virtual desktop), and then, after
> several minutes, only XMMS got CPU time, the rest of the applications
> (at least, those running over X-Window) get stalled.

We know there are still some issues and we need help from people like
you. It's testing from a big enough user population what allows us to
fix things that don't work as expected :-)

If you can, please, keem trying/testing/using the -mm series of the
kernel. Con Kolivas is dedicating a lot of effort on the scheduler
issus, and I wouldn't like this effort to be useless in the end.

Thanks!

