Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSDOUVZ>; Mon, 15 Apr 2002 16:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSDOUVY>; Mon, 15 Apr 2002 16:21:24 -0400
Received: from [195.39.17.254] ([195.39.17.254]:14220 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313199AbSDOUVY>;
	Mon, 15 Apr 2002 16:21:24 -0400
Date: Mon, 8 Apr 2002 20:38:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] writeback daemons
Message-ID: <20020408203839.C540@toy.ucw.cz>
In-Reply-To: <3CB3DE1E.5F811D77@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The number of threads is dynamically managed by a simple
> demand-driven algorithm.

So... when we are low on free memory, we try to create more threads... Possible
deadlock?
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

