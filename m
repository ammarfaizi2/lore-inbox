Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135913AbRD3VsC>; Mon, 30 Apr 2001 17:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135914AbRD3Vrn>; Mon, 30 Apr 2001 17:47:43 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:38412 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S135913AbRD3Vrg>; Mon, 30 Apr 2001 17:47:36 -0400
Date: Mon, 30 Apr 2001 14:47:35 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David S. Miller" <davem@redhat.com>, Fabio Riccardi <fabio@chromium.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Smith <x@xman.org>,
        Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEDBEB8.449D88C3@chromium.com>
Message-ID: <Pine.LNX.4.33.0104301444160.14436-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Fabio Riccardi wrote:

> Ok I fixed it, the header date timestamp is updated with every request.
>
> Performance doesn't seem to have suffered significantly (less than 1%).

rad!

> BTW: Don't call me slime, I wasn't trying to cheat, I just didn't know that
> the date stamp was required to be really up-to-date.

sorry, i meant to put a smily on there :)


On Sun, 29 Apr 2001, David S. Miller wrote:

> If you do the TCP_CORK thing, what you end up with is a scatter gather
> entry in the SKB for the header bits, then the page cache segments.

so then the NIC would be sent a 3 entry gather list -- 1 entry for TCP/IP
headers, 1 for HTTP headers, and 1 for the initial page cache segment?

are there any NICs which take only 2 entry lists?  (boo hiss and curses
on such things if they exist!)

-dean

