Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274239AbRIXXIg>; Mon, 24 Sep 2001 19:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274235AbRIXXI1>; Mon, 24 Sep 2001 19:08:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274121AbRIXXIM>; Mon, 24 Sep 2001 19:08:12 -0400
Date: Mon, 24 Sep 2001 16:06:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bob Matthews <bmatthews@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Preliminary testing results for 2.4.10
In-Reply-To: <3BAFB108.22D81127@redhat.com>
Message-ID: <Pine.LNX.4.33.0109241605080.13605-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Sep 2001, Bob Matthews wrote:
>
> machine test1:  2xPIII, 2G RAM/4G Swap.  Appears to be in a memory
> related deadlock.  All test related processes save one are in D state.
> Vmstat indicates no swapping activity.  Top says both processors are
> ~95% idle.  The exception is the TTCP test, which has a very small
> memory footprint and is running normally.

Can you check what "ctrl + ScrollLock" says?

That will give you a nice list of all processes, along with their
backtraces. Very useful indeed for finding deadlocks..

		Linus

