Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSILH4l>; Thu, 12 Sep 2002 03:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSILH4k>; Thu, 12 Sep 2002 03:56:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39337 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313558AbSILH4L>;
	Thu, 12 Sep 2002 03:56:11 -0400
Date: Thu, 12 Sep 2002 10:06:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209112300470.22694-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209121005430.5452-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Sep 2002, Tobias Ringstrom wrote:

> In other words:  Any nice-0 task that has been sleeping for two seconds
> or more will be able to monololize the CPU for up to 0.7 seconds.  Do
> you agree that this is a problem, or am I being too narrow-minded?  :-)

well, 'monopolize' the CPU from CPU-hogs - yes. Take the CPU from other
interactive tasks: no.

	Ingo

