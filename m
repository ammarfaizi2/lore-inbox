Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266098AbRF2OuY>; Fri, 29 Jun 2001 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbRF2OuO>; Fri, 29 Jun 2001 10:50:14 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:9747 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S266098AbRF2OuA>;
	Fri, 29 Jun 2001 10:50:00 -0400
Date: Fri, 29 Jun 2001 17:49:58 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 1-order allocation failed
In-Reply-To: <3B3B28A6.A2457959@gointernet.co.uk>
Message-ID: <Pine.LNX.4.33.0106291749010.2015-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem, and some other strange problems, booting with the
'noapic' option solved them ...
(sorry for the late reply, I was still testing the machine... )

On Thu, 28 Jun 2001, Eugenio Mastroviti wrote:

> This is possibly not the best place to post this message, but if anybody
> could help I'd be very grateful...
>
> Twice at about the same time one of our server, running kernel 2.4.4,
> has died. Attached is an excerpt from syslog - the actual list of
> messages is 5 or 6 times longer, all with the same timestamp - after
> this the machine froze until it was rebooted, about an hour later.
>
> The server is a dual-CPU Dell 2450 with 1.5GB RAM, 1.5GB swap, Megaraid
> controller, running application server software
>
> Another identical server in the same subnet, running the same kind of
> software with kernel 2.2.16 without any modification, is running fine in
> spite of the bigger load on it (more threads, larger memory usage)
>
> Eugenio Mastroviti
>
> Systems Administrator
>
> Go Internet Ltd

