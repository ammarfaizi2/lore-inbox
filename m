Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWBMP5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWBMP5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWBMP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:57:39 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:2529 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750783AbWBMP5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:57:38 -0500
Date: Mon, 13 Feb 2006 16:57:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] hrtimer: optimize hrtimer_run_queues
In-Reply-To: <20060213133944.GA12923@elte.hu>
Message-ID: <Pine.LNX.4.61.0602131654470.30994@scrub.home>
References: <Pine.LNX.4.61.0602130210120.23827@scrub.home> <20060213133944.GA12923@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> hm, we can do this - although the open-coded loop looks ugly. In any 
> case, this is an optimization, and not necessary for v2.6.16. It is 
> certainly ok for -mm.

I could also call this perfomance regressions to 2.6.15, unless there is 
a good reason not to include them, I'd prefer to see it in 2.6.16.

bye, Roman
