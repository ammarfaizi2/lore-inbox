Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312024AbSCQNX6>; Sun, 17 Mar 2002 08:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312025AbSCQNXt>; Sun, 17 Mar 2002 08:23:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:57099 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312024AbSCQNXg>;
	Sun, 17 Mar 2002 08:23:36 -0500
Date: Sun, 17 Mar 2002 10:23:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0203171021090.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Linus Torvalds wrote:
> On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> >
> > What about 2M pages?
>
> Not useful for generic loads right now, and the latencies for clearing or
> copying them them etc (ie single page faults - nopage or COW) are still
> big enough that it would likely be a performance problem at that level.
> And while doing IO in 2MB chunks sounds like fun, since most files are
> still just a few kB,

In other words, large pages should be a "special hack" for
special applications, like Oracle and maybe some scientific
calculations ?

Grabbing some bitflags in generic datastructures shouldn't
be an issue since free bits are available.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

