Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSDIQio>; Tue, 9 Apr 2002 12:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSDIQin>; Tue, 9 Apr 2002 12:38:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:907 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S293596AbSDIQim>;
	Tue, 9 Apr 2002 12:38:42 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 9 Apr 2002 16:38:41 GMT
Message-Id: <UTC200204091638.QAA519161.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH][CFT] IDE TCQ #2
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > In my opinion sysctl() is worthless. It uses an array of numbers
    > where ioctl() uses a single number. Especially since the names are
    > already in the kernel it is much clearer and cleaner to use a
    > pathname. I wouldn't mind if sysctl() disappeared entirely.

    Please have a look at /proc/sys/ OK?

    > Also ioctl() has its problems. First of all, nobody knows what the
    > prototype is. Secondly, it is too rigid - the moment one needs a
    > larger structure one needs a different ioctl.
    > 
    > A text based interface is much more flexible. If the number of
    > cylinders of a disk no longer fits in a short, well doesn't matter,
    > then the number of digits may increase but the interface remains
    > unchanged. Of course the price is that one has to parse, but
    > typically that is not a problem.

What do you want me to see in /proc/sys/?
Pathnames? That is what I like.
I dislike the system call, with its ugly numbers.

Andries

