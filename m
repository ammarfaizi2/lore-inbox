Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTBXPui>; Mon, 24 Feb 2003 10:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTBXPui>; Mon, 24 Feb 2003 10:50:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64225 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267196AbTBXPuh>; Mon, 24 Feb 2003 10:50:37 -0500
Date: Mon, 24 Feb 2003 08:00:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <8520000.1046102445@[10.10.2.4]>
In-Reply-To: <20030224154725.GB5665@work.bitmover.com>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmast
 er.ca> <1510000.1045942974@[10.10.2.4]>
 <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]>
 <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]>
 <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]>
 <20030224065826.GA5665@work.bitmover.com>
 <20030224075142.GA10396@holomorphy.com>
 <20030224154725.GB5665@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I never said that I didn't.  I'm just taking issue with the choosen path
> which has been demonstrated to not work.
> 
> "Let's scale Linux by multi threading"
> 
>     "Err, that really sucked for everyone who has tried it in the past,
> all     the code paths got long and uniprocessor performance suffered"
> 
> "Oh, but we won't do that, that would be bad".
> 
>     "Great, how about you measure the changes carefully and really show
> that?"
> 
> "We don't need to measure the changes, we know we'll do it right".

Most of the threading changes have been things like 1 thread per cpu, which
would seem to scale up and down rather well to me ... could you illustrate
by  pointing  to an example of something that's changed in that area which
you think is bad? Yes, if Linux started 2000 kernel threads on a UP system,
that would obviously be bad.

M.

