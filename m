Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272621AbRIGMah>; Fri, 7 Sep 2001 08:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272622AbRIGMa1>; Fri, 7 Sep 2001 08:30:27 -0400
Received: from ns.ithnet.com ([217.64.64.10]:11790 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272621AbRIGMaW>;
	Fri, 7 Sep 2001 08:30:22 -0400
Date: Fri, 7 Sep 2001 14:30:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: riel@conectiva.com.br, jaharkes@cs.cmu.edu, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-Id: <20010907143021.3cefbf74.skraw@ithnet.com>
In-Reply-To: <20010906174422Z16127-26184+6@humbolt.nl.linux.org>
In-Reply-To: <Pine.LNX.4.33L.0109060851020.31200-100000@imladris.rielhome.conectiva>
	<20010906122459Z16031-32383+3771@humbolt.nl.linux.org>
	<20010906151015.69d2afb2.skraw@ithnet.com>
	<20010906174422Z16127-26184+6@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001 19:51:26 +0200 Daniel Phillips <phillips@bonn-fries.net>
wrote:

> On September 6, 2001 03:10 pm, Stephan von Krawczynski wrote:
> > [...]
> > to lots on the nfs-data. Even if the nfs-data would only have one single
hit,
> > the old CD image should have been removed, because it is inactive and
_older_.
> 
> OK, this is not related to what we were discussing (IO latency).  It's not
too
> hard to fix, we just need to do a little aging whenever there are
allocations,
> whether or not there is memory_pressure.  I don't think it's a real problem
> though, we have at least two problems we really do need to fix (oom and
> high order failures).

Hm, I am not quite sure about that. Can you _show_ me how to fix this?

Regards,
Stephan

