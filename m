Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSFJXfm>; Mon, 10 Jun 2002 19:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSFJXfl>; Mon, 10 Jun 2002 19:35:41 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:41721 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316541AbSFJXfk>; Mon, 10 Jun 2002 19:35:40 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Paul Menage <pmenage@ensim.com>
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
Date: Tue, 11 Jun 2002 09:32:44 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, pmenage@ensim.com
In-Reply-To: <E17HYSZ-0000CY-00@pmenage-dt.ensim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206110932.44185.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 09:20, Paul Menage wrote:
> In article <0C01A29FBAE24448A792F5C68F5EA47D29DD32@nasdaq.ms.ensim.com>,
>
> you write:
> >Is there any documentation on the netlink API, beyond UTSL(iproute)?
> >Reference would be good, but a tutorial would be ideal.
>
> The man pages for netlink(3), netlink(7), rtnetlink(3) and rtnetlink(7)
> give a basic reference.
Unfortunately my brain is not on the same level and scope as Alexey or davem. 

I simply don't grok those pages. I also note caveats about incompleteness, and 
recommendation to use libnetlink, which is also not documented much.

I sometimes hack on zcip (see ftp://ftp.kernel.org/pub/software/network/zcip 
for an out of date version), and it could really use some netlink-ification. 
But I can't even follow enough of iproute (or zebra, which also uses netlink, 
AFAICT) to figure out how to do basic stuff like a list of configured 
networking devices, or set the default route.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
