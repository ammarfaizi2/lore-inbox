Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136660AbREGUXr>; Mon, 7 May 2001 16:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136661AbREGUXh>; Mon, 7 May 2001 16:23:37 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:6673 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S136660AbREGUXW>; Mon, 7 May 2001 16:23:22 -0400
Date: Mon, 7 May 2001 13:23:21 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <alexander.eichhorn@rz.tu-ilmenau.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <Pine.LNX.3.95.1010507145625.6441A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0105071315140.31093-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Richard B. Johnson wrote:

> When we get to media that can sink data as fast as we can generate
> them (it), then we have to worry about memory copy speed. However,
> these new devices are actually an IP subsystem.  They generate and
> receive entire datagrams. To fully utilize these devices, the data-
> gram generation and reception (the basis of all TCP/IP networking)
> will have to be moved out of the kernel and into these boards. The
> kernel code will only handle interfaces, connections, and rules.

heh, and then these things will be expensive, so few will buy them and
they'll remain in older process technologies (like .21u) because there's
no economy of scale, while CPUs jump ahead to fewer and fewer microns
(.13u, .10u), and in a moore's law doubling or so someone will come up
with the bright idea to move everything back to the CPU again and use
mostly dumb i/o devices.  (or they'll use a bunch of general purpose
computers clustered behind inexpensive switches to achieve the same
thing at a fraction of the cost.)

we've never seen this happen before!  :)

-dean

