Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbRBKVFj>; Sun, 11 Feb 2001 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRBKVF3>; Sun, 11 Feb 2001 16:05:29 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:56073 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130378AbRBKVFJ>; Sun, 11 Feb 2001 16:05:09 -0500
Date: Sun, 11 Feb 2001 21:05:07 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Andi Kleen <ak@suse.de>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: BUG: SO_LINGER + shutdown() does not block?
In-Reply-To: <20010211215133.A11396@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0102112103530.25011-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Feb 2001, Andi Kleen wrote:

> On Sun, Feb 11, 2001 at 08:41:04PM +0000, Chris Evans wrote:
> >
> > [cc: Andi]
>
> Missing context..

[...]

> What do you exactly think is wrong?

man socket(7) says that setting SO_LINGER on a socket will make shutdown()
and close() block. That's incorrect; only close() blocks.

Sorry for the missing context.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
