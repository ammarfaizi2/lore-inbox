Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbREOEpN>; Tue, 15 May 2001 00:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbREOEox>; Tue, 15 May 2001 00:44:53 -0400
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.102.89.11]:9459 "HELO
	scotch.homeip.net") by vger.kernel.org with SMTP id <S262627AbREOEom>;
	Tue, 15 May 2001 00:44:42 -0400
Date: Tue, 15 May 2001 00:44:24 -0400 (EDT)
From: God <atm@sdk.ca>
To: "David S. Miller" <davem@redhat.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: TCP capture effect :: estimate queue length ?
In-Reply-To: <15104.43139.354492.914572@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105150030160.23642-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, David S. Miller wrote:

> God writes:
>  > Speaking of queues on routers/servers, does such a util exist that would
>  > measure (even a rough estimate), what level of congestion (queueing) is
>  > happening between point A and B ?
> 
> Not that I know of, but it is funny you mention this because this is
> basically the kind of calculation the TCP Vegas congestion avoidance
> scheme attempts to make.  At it's core, it is trying to estimate the
> size of router queues from local machine to remote machine based upon
> "congestion events" (packet drop, etc.).


Really? .. hmmm... might just have to go read up on it.  I have my own
ideas of how to go about doing it (pretty simple I think .. unless I'm
missing something other then coding ability .... heh). 

 My basic reason for wanting such a beast was to
convince one internet provider (who shall remain nameless), that from
at home *cough* to the gateway, was under extreame congestion.  After
finaly speaking with a tech who knew the difference between him and
a dip switch, he agreed there was a serious problem (queues
were exceeding 190/255 tx/rx, logs were showing the link upstream
from the gateway was loosing sync multiple times per hour .. etc etc).

The path to that however was long and very frustrating.  Trying to explain
that
although you can ping me fine and I can ping you fine, you still have a
serious problem; can be very confusing to some.


Thanks for the pointer :)



