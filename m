Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSBDW6v>; Mon, 4 Feb 2002 17:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSBDW6m>; Mon, 4 Feb 2002 17:58:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5812 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289239AbSBDW6a>;
	Mon, 4 Feb 2002 17:58:30 -0500
Date: Tue, 5 Feb 2002 01:56:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: Ed Tomlinson <tomlins@cam.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C5F1191.D90D7556@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202050155370.19367-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Jussi Laako wrote:

> Ok, now I made comparison test with exactly same kernel except other
> one with -K2 patch. O1-K2 behaves significantly worse than old
> scheduler. I think this behaviour was introduced somewhere around
> beginning of -J series. I can't make kernel with old scheduler loose
> datablocks, but with O1 it looses large percentage of the blocks.

what does 'loose datablocks' mean? What application loses datablocks?

	Ingo

