Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131209AbRCUGmr>; Wed, 21 Mar 2001 01:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131224AbRCUGmh>; Wed, 21 Mar 2001 01:42:37 -0500
Received: from www.wen-online.de ([212.223.88.39]:64274 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131219AbRCUGmb>;
	Wed, 21 Mar 2001 01:42:31 -0500
Date: Wed, 21 Mar 2001 07:41:55 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
Message-ID: <Pine.LNX.4.33.0103210733470.929-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar 2001, Kevin Buhr wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
> >
> > Cool. Somebody actually found a real case.
> >
> > I'll fix the mmap case asap. Its' not hard, I just waited to see if it
> > ever actually triggers. Something like g++ certainly counts as major.
>
> I frequently build Mozilla from scratch on my (aging) dual Celeron
> machine.  That's about 65 megs of actual C++ source, and it takes
> about an hour of real time to compile.  I see times for the whole
> build like this:
>
>     real    60m4.574s
>     user    101m18.260s  <-- impossible no?
>     sys     3m23.520s

Why do numbers like this show up?  I noticed some of this after having
enabled SMP on my UP box.

	-Mike

