Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135545AbRAHJOd>; Mon, 8 Jan 2001 04:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHJOY>; Mon, 8 Jan 2001 04:14:24 -0500
Received: from james.kalifornia.com ([208.179.0.2]:54142 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S135545AbRAHJOI>; Mon, 8 Jan 2001 04:14:08 -0500
Date: Mon, 8 Jan 2001 01:13:41 -0800 (PST)
From: David Ford <david@linux.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: timw@splhi.com, Christian Loth <chris@gidayu.max.uni-duisburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
In-Reply-To: <3A598474.3A69C684@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10101080110410.12242-100000@Huntington-Beach.Blue-Labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Andrew Morton wrote:
> Obviously, something changed between 2.2.14 and more current
> kernels which broke pump.  I don't believe it's a driver change
> because it also affects the 3c90x driver.  I don't have a theory
> as to why this affects the 3com NICs though.  But I'm assuming
> that whatever broke pump also broke dhcpcd.
> 
> I note that with 3c59x in 2.4.0, pump-0.7.3 basically freezes up.
> It spits out a single bootp packet then goes to lunch.  I got
> bored waiting after ten minutes. So an upgrade is definitely needed.


IMO, pump is a POS.  I have had more complaints from others and troubles
with it personally than I care to acknowledge.  dhcpcd has worked great for
me for as long as I can recall.  dhclient also seems to work just fine.

I've used all of these from 2.2 on through 2.3 and currently using dhcpcd
and dhclient with 2.4 on tulips and 3coms.

-d

---NOTICE--- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
