Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbREWEvE>; Wed, 23 May 2001 00:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262996AbREWEup>; Wed, 23 May 2001 00:50:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51612 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262994AbREWEuZ>;
	Wed, 23 May 2001 00:50:25 -0400
Date: Wed, 23 May 2001 00:50:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Edgar Toernig <froese@gmx.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B0B3A4C.FD7143F9@gmx.de>
Message-ID: <Pine.GSO.4.21.0105230043460.17373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Edgar Toernig wrote:

> And with special "ctrl" devices (ie /dev/ttyS0 and /dev/ttyS0ctrl):
> This _may_ work for some kind of devices.  But serial ports are one
> example where it simply will _not_.  It requires that you know the

That's quite funny, you know...

------------------------------------------------------------------------
From: Dennis Ritchie (dmr@bell-labs.com)
Subject: Re: Plan 9 (was Re: Rubouts)
Newsgroups: alt.folklore.computers
Date: 1998/10/12
   
Neil Franklin wrote:
>
> No ioctl()s?
>
> Something like:    echo "38400,8,n,1" > /ioctrl/ttyS0    ?
>
> Now that would be cool.
>
Exactly like that, though it would be /dev/eia80ctl .
No ioctl().

> Is there anyone who has an URL about Plan 9. Code download?
>

 http://plan9.bell-labs.com/plan9


        Dennis
------------------------------------------------------------------------

