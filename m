Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRASFgZ>; Fri, 19 Jan 2001 00:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRASFgP>; Fri, 19 Jan 2001 00:36:15 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:41991 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129807AbRASFgF>; Fri, 19 Jan 2001 00:36:05 -0500
Date: Fri, 19 Jan 2001 07:49:37 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Jens Axboe <axboe@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1pre8 slowdown on dbench tests
In-Reply-To: <20010119031303.D18452@suse.de>
Message-ID: <Pine.LNX.4.30.0101190733530.1729-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jan 2001, Jens Axboe wrote:
> On Fri, Jan 19 2001, Szabolcs Szakacsits wrote:
> > Redone with big enough swap by requests.
> > 2.4.0,132MB swap
> > 548.81user 128.97system    11:22  99%CPU (442433major+705419minor)
> > 561.12user 171.06system    12:29  97%CPU (446949major+712525minor)
> > 625.68user 2833.29system 1:12:38  79%CPU (638957major+1463974minor)
> > ===========
> > 2.4.1pre8,132MB swap
> > 548.71user 117.93system    11:09  99%CPU (442434major+705420minor)
> > 558.93user 166.82system    12:20  98%CPU (446941major+712662minor)
> > 621.37user 2592.54system 1:07:33  79%CPU (592679major+1311442minor)
>
> Better, could you try with the number changes that Andrea suggested
> too? Thanks.

Helped intensive swapping a bit, degraded other cases [no or slight
swapping].

2.4.1pre8,32MB RAM,132MB swap,blk suggestion
544.19user 141.25system    11:31  99%CPU (442419major+705411minor)
554.83user 191.57system    12:41  98%CPU (445762major+710409minor)
612.05user 2551.37system 1:07:21  78%CPU (589623major+1313665minor)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
