Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbRAWHUf>; Tue, 23 Jan 2001 02:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135522AbRAWHU0>; Tue, 23 Jan 2001 02:20:26 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:4113 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130138AbRAWHUO>; Tue, 23 Jan 2001 02:20:14 -0500
Date: Mon, 22 Jan 2001 23:20:08 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <7uDh9dHmw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.30.0101222314360.18469-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jan 2001, Kai Henningsen wrote:

> dean-list-linux-kernel@arctic.org (dean gaudet)  wrote on 18.01.01 in <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>:
>
> > i'm pretty sure the actual use of pipelining is pretty disappointing.
> > the work i did in apache preceded the widespread use of HTTP/1.1 and we
>
> What widespread use of HTTP/1.1?
>
> I justtried the following excercise:
>
> Request a nonexistant page with HTTP/1.1 syntax.
>
> a. Directly from Apache: I get a nice chunked HTTP/1.1 answer.
> b. Via Squid: I get a plain HTTP/1.0 answer.
>
> As long as not even Squid talks 1.1, how can we expect browsers to do it?
>
> WebMUX? In a thousand years perhaps.

what's the widespread use of ECN?  or SACK when that was first put in?
what about ipchains before 2.2 was released?

why bother being the first to implement anything new, might as well wait
for the commercial folks to put it into a product and spread it wide and
far eh?

i'm pretty sure i said that it was our (the apache group's) position that
we wanted as perfect as possible of a pipelining implementation so that
should someone finally do a client-side version then there wouldn't be
apache bottlenecks in the way.  i still think that's the right attitude.
if we'd left the packet boundaries in there then there wouldn't even be
motivation to bother doing a client-side pipelining implementation,
there'd be little or no benefit.

btw, HTTP/1.1 proxying is more challenging than HTTP/1.0 proxying which is
probably why squid doesn't support it yet (nor does the apache proxy
module).

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
