Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287639AbSAEKpS>; Sat, 5 Jan 2002 05:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287641AbSAEKpI>; Sat, 5 Jan 2002 05:45:08 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24463 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287639AbSAEKpB>;
	Sat, 5 Jan 2002 05:45:01 -0500
Date: Sat, 5 Jan 2002 13:42:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <200201050031.g050V7217956@mailf.telia.com>
Message-ID: <Pine.LNX.4.33.0201051341200.3026-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Roger Larsson wrote:

> The preemtion kernel adds protection to per process data... And it is
> not (yet) updated to handle the O(1) scheduler!

yes - what i meant was that there is no conceptual problem with having
both the preemption kernel and an O(1) scheduler. There are practical
problems though, because both change similar code areas, albeit for
different and orthogonal reasons.

	Ingo

