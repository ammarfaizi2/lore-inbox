Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbRGYXHo>; Wed, 25 Jul 2001 19:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbRGYXHf>; Wed, 25 Jul 2001 19:07:35 -0400
Received: from noella.mindsec.com ([209.172.192.12]:41385 "EHLO
	noella.mindsec.com") by vger.kernel.org with ESMTP
	id <S267390AbRGYXHX>; Wed, 25 Jul 2001 19:07:23 -0400
Date: Wed, 25 Jul 2001 16:07:27 -0700 (PDT)
From: Erik <eparker@mindsec.com>
To: Bernd Eckenfels <W1012@lina.inka.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: route problem.. kernel/driver ?
In-Reply-To: <E15PWN6-0001IA-00@sites.inka.de>
Message-ID: <Pine.GSO.4.33.0107251605050.18465-100000@noella.mindsec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


After doing the same research I've been doing the past week or so.. I'm
coming back to the conclusion that you "can't" have two default routes.

Which doesn't explain why it works at all.

We need this machine to answer on two ip addresses on different networks
to the internet. One that comes in one router, on one t1.. and one that
comes in on another router, on a different t1. And it needs to respond
back out of the same interface.

But it does just that.. I can send mail to mx.domain.com and
mx3.domain.com and it hits whichever interface.. I can send traffic out
both of them. One just dies at random.

I don't even really need two DEFAULTS.. I just need the machine to be seen
on the internet, by two totally different IP's on seperate routes.

Is it a bug with the nic card, or is this impossible? If it's impossible,
how do people multihome linux boxes, without using bgp?

On Wed, 25 Jul 2001, Bernd Eckenfels wrote:

> In article <Pine.GSO.4.33.0107251342100.14023-100000@noella.mindsec.com> you wrote:
> > I'm at a loss.. Any thoughts?
>
> Just dont use two default routes.
>
> Greetings
> Bernd




---
Erik Parker
---

