Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269140AbRHBUrY>; Thu, 2 Aug 2001 16:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269143AbRHBUrO>; Thu, 2 Aug 2001 16:47:14 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:60159 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S269140AbRHBUrB>;
	Thu, 2 Aug 2001 16:47:01 -0400
Date: Thu, 2 Aug 2001 22:47:08 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd eats the cpu without swap
Message-ID: <Pine.A41.4.31.0108022246140.43560-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Aug 2001, Peter [iso-8859-1] Wächtler wrote:

> In a former message you wrote:
> "I have 160M of ram, and I don't use swap at all,"
>
> Then you meant: no single page was swapped out?

yes. I don't attach any swap file to the system.

> I thought you was observing the same as me:
>
> when the system runs low on memory (on a 64MB setop box like device
> with _no_ swap partition/file), the harddisk gets very active and
				      ^^^^^^^^^^^^^^^^^^^^^^^^^
there was _no_ harddisk activity.
and the size of the buffer cache was 19MB.

the bug is reproducable, but I don't know how to do that :/
it showed up 3 times.

Bye,
Szabi



