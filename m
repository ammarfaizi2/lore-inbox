Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261355AbRELXy4>; Sat, 12 May 2001 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbRELXyq>; Sat, 12 May 2001 19:54:46 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:64980 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S261355AbRELXyc>;
	Sat, 12 May 2001 19:54:32 -0400
Date: Sun, 13 May 2001 01:54:30 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: Alexander Viro <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
In-Reply-To: <Pine.GSO.4.21.0105121935570.11973-100000@weyl.math.psu.edu>
Message-ID: <Pine.A41.4.31.0105130146200.19270-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2001, Alexander Viro wrote:

> > > Just what behaviour had you expected?
> > maybe that I don't have to shutdown?
> > I think it's a *bad* behaviour
>
> Erm... Let me restate: what did you expect to achieve with that?
nothing
I have an unused partition, what I use sometimes as fs, sometimes as swap.
that partition is /dev/hdc2
this time I really ran out of memory (0kfree swap), so I wanted swapon as
soon as possible, and accidentally I typed /dev/hdb2 instead of
/dev/hdc2.

> Swap on device means that all contents of that device is lost.
> Mounting fs from device generally means that you don't want the
> loss of contents. At least until you unmount the thing.
I know...

Bye,
Szabi


