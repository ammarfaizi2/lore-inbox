Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266360AbRGJOMb>; Tue, 10 Jul 2001 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266361AbRGJOMV>; Tue, 10 Jul 2001 10:12:21 -0400
Received: from ns.caldera.de ([212.34.180.1]:16840 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S266360AbRGJOMR>;
	Tue, 10 Jul 2001 10:12:17 -0400
Date: Tue, 10 Jul 2001 16:12:00 +0200
Message-Id: <200107101412.f6AEC0W06951@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: cw@f00f.org (Chris Wedgwood)
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010711015128.E31799@weta.f00f.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010711015128.E31799@weta.f00f.org> you wrote:
> On Mon, Jul 09, 2001 at 10:34:24PM -0700, H. Peter Anvin wrote:
>
>     It supports up to 32, if you can find a machine that has that
>     many.
>
> I think 8-way is about as high as anything common goes to, maybe
> 16. The cpu array is declared 32 long, maybe this should be changed to
> 8 by default?

Why limit the user?  There are more than enough Linux system that have
more than 32 CPUs (SGI, DEC, Sun).

Making it a per-architecture value or even a config option make a lot
more sense.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
