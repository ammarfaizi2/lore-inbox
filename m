Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSIBNhg>; Mon, 2 Sep 2002 09:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318299AbSIBNhg>; Mon, 2 Sep 2002 09:37:36 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:14729 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318297AbSIBNhf>; Mon, 2 Sep 2002 09:37:35 -0400
Date: Mon, 2 Sep 2002 15:42:00 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <1030972033.3490.57.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209021538070.7718-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Sep 2002, Alan Cox wrote:

> It isnt a regression, its a bug fix. The nice value is now being
> honoured properly.

The problem is that the kernel decided to nice the process (by changing
the priority, not the nice value) as if it was a background task, but it's
not a background task.  On the contrary, it's highly interactive.

/Tobias

