Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311171AbSCLND7>; Tue, 12 Mar 2002 08:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311175AbSCLNDu>; Tue, 12 Mar 2002 08:03:50 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:22287 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S311171AbSCLNDr>; Tue, 12 Mar 2002 08:03:47 -0500
Date: Tue, 12 Mar 2002 05:03:45 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David S. Miller" <davem@redhat.com>
cc: <michael@metaparadigm.com>, <bcrl@redhat.com>, <whitney@math.berkeley.edu>,
        <rgooch@ras.ucalgary.ca>, <linux-kernel@vger.kernel.org>,
        <marcelo@conectiva.com.br>
Subject: Re: [patch] ns83820 0.17
In-Reply-To: <20020312.031509.53067416.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0203120457300.27360-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, David S. Miller wrote:

>    From: Michael Clark <michael@metaparadigm.com>
>    Date: Tue, 12 Mar 2002 19:00:09 +0800
>
>    Dave, what performance do you get with the sk98 using normal size
>    frames? (to compare apples with apples). BTW - i can't try jumbo
>    frames due to my crappy 3com gig switch.
>
> Use a cross-over cable to play with Jumbo frames, that is
> what I do :-)

you shouldn't even need a crossover cable :)  1000baseT NICs should figure
out what the wire pairings are and adjust the DSP accordingly.  at least
the acenic-based cards seem to work host-to-host with a regular patch
cable or a cross-over (or a hacked up pairing i tried which crossed over
both the two 100baseT pairs and the other 2 pairs which aren't usually
crossed over).

-dean

