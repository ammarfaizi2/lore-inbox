Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129900AbRCAUa0>; Thu, 1 Mar 2001 15:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129899AbRCAUaR>; Thu, 1 Mar 2001 15:30:17 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129876AbRCAUaH>;
	Thu, 1 Mar 2001 15:30:07 -0500
Date: Sat, 1 Jan 2000 00:28:42 +0000
From: Pavel Machek <pavel@suse.cz>
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new setprocuid syscall
Message-ID: <20000101002842.A28@(none)>
In-Reply-To: <E14VDD2-0006ha-00@the-village.bc.nu> <Pine.A41.4.31.0102201759300.50000-100000@pandora.inf.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.A41.4.31.0102201759300.50000-100000@pandora.inf.elte.hu>; from szabi@inf.elte.hu on Tue, Feb 20, 2001 at 06:04:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> The conclusion: it's cannot be implemented without slowdown.
> So ignore my patch.

Of course it can.

One possibility would be to implement it as ptrace(SETUID) and only
allow it if we know other task is not in kernel. [And then cean up any 
remaining problems.]

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

