Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSFKAOY>; Mon, 10 Jun 2002 20:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSFKAOX>; Mon, 10 Jun 2002 20:14:23 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:7924 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316576AbSFKAOX>; Mon, 10 Jun 2002 20:14:23 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
Date: Tue, 11 Jun 2002 10:11:28 +1000
User-Agent: KMail/1.4.5
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0206101634320.9527-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206111011.28955.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 09:36, Randy.Dunlap wrote:
> On Tue, 11 Jun 2002, Brad Hards wrote:
> | On Tue, 11 Jun 2002 09:20, Paul Menage wrote:
> | > In article
> | > <0C01A29FBAE24448A792F5C68F5EA47D29DD32@nasdaq.ms.ensim.com>,
> | >
> | > you write:
> | > >Is there any documentation on the netlink API, beyond UTSL(iproute)?
> | > >Reference would be good, but a tutorial would be ideal.
> | >
> | > The man pages for netlink(3), netlink(7), rtnetlink(3) and rtnetlink(7)
> | > give a basic reference.
> |
> | Unfortunately my brain is not on the same level and scope as Alexey or
> | davem.
> |
> | I simply don't grok those pages. I also note caveats about
> | incompleteness, and recommendation to use libnetlink, which is also not
> | documented much.
>
> Hi Brad,
>
> There was an announcement earlier today of some networking
> documentation.  I think that it's still in its early stages, though.
Very early, from my review :)

> From the 'netdev' list:
>
> Hi,
>
> I am working on a doc on "Networking Subsystem" in the Linux kernel.
> This
> is part of the "Linux Kernel documentation project" (www.lkdp.tk).
And this is the wrong focus (for me). I need documentation from the userspace 
view. The documentation I need shouldn't try to explain how the kernel works, 
except as  needed to understand what to do in userspace. My concept is 
something like the tutorial I am working on for Linux HID programming 
(explaination of the various interfaces and options - see 
http://www.frogmouth.net/hid-doco/linux-hid.html for an early draft).

Not to suggest we shouldn't document the kernel mechanics - this is important 
too.

But kernel programmers need to remember that user space programmers will take 
the path of least resistance when trying to interact with the kernel. Good 
documentation and easy-to-copy examples beats a slightly more powerful API 
(where slightly depends on being able to accomplish task in both APIs, even 
if it gets ugly) every time. If you want people to switch over to your new 
API/ABI, its got to be easy.
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
