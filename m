Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312136AbSDIXCE>; Tue, 9 Apr 2002 19:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312141AbSDIXCD>; Tue, 9 Apr 2002 19:02:03 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:50439 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S312136AbSDIXCC>;
	Tue, 9 Apr 2002 19:02:02 -0400
Date: Tue, 9 Apr 2002 19:01:58 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Corey Minyard <minyard@acm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Further WatchDog Updates
In-Reply-To: <3CB30EE1.4020407@acm.org>
Message-ID: <Pine.LNX.4.33.0204091652170.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Apr 2002, Corey Minyard wrote:

> The actual reason for a small timeout is if the system is in a
> high-throughput highly available application, to get the board out of
> commission as soon as possible and avoid a big delay in message handling
> and/or lose as little traffic as possible.  Or if the system can fail
> and start misbehaving, to kill it as soon as possible to minimize the
> damage.  With the preemptable kernel and real-time processes, it's not
> unreasonable to schedule something every 250ms.

Oops, I forgot.  Since you can set the timeout to 1 second, you would
really only be losing 750ms.  Right now the API says timeout in seconds,
maybe that will change in 2.5, maybe not, and I'm not sure what the
reception would be to an option for granularity.

Regards,
Rob Radez

