Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277666AbRJIAgT>; Mon, 8 Oct 2001 20:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277667AbRJIAgJ>; Mon, 8 Oct 2001 20:36:09 -0400
Received: from laird.sea.internap.com ([206.253.215.165]:49451 "EHLO
	laird.sea.internap.com") by vger.kernel.org with ESMTP
	id <S277666AbRJIAf5>; Mon, 8 Oct 2001 20:35:57 -0400
Date: Mon, 8 Oct 2001 17:36:21 -0700 (PDT)
From: Scott Laird <laird@internap.com>
X-X-Sender: <laird@laird.sea.internap.com>
To: jamal <hadi@cyberus.ca>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110081024440.5473-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110081717030.5961-100000@laird.sea.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Oct 2001, jamal wrote:
>
> Several things to note/observe:
> - They use some very specialized piece of hardware (with two PCI buses).

Huh?  It was just an L440GX, which was probably the single most common PC
server board for a while in 1999-2000.  Most of VA Linux's systems used
them.  I wouldn't call them "very specialized."

> - Roberts results on a single PCI bus hardware was showing ~360Kpps
> routing vs clicks 435Kpps. This is not "far off" given the differences in
> hardware. What would be really interesting is to have the click folks
> post their latency results. I am curious as to what a purely polling
> scheme they have would achieve (as opposed to NAPI which is a mixture of
> interupts and polls).

Their 'TOCS00' paper lists a 29us one-way latency on page 22.

Click looks interesting, much more so then most academic network projects,
but I'm still not sure if it'd really be useful in most "real"
environments.  It looks too flexible for most people to manage.  It'd be
an interesting addition to my test lab, though :-).


Scott

