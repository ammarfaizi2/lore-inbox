Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136409AbRAHFcm>; Mon, 8 Jan 2001 00:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136730AbRAHFcc>; Mon, 8 Jan 2001 00:32:32 -0500
Received: from Cantor.suse.de ([194.112.123.193]:35598 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136409AbRAHFcS>;
	Mon, 8 Jan 2001 00:32:18 -0500
Date: Mon, 8 Jan 2001 06:32:14 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: cw@f00f.org, david@linux.com, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010108063214.A29026@gruyere.muc.suse.de>
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org> <Pine.LNX.4.10.10101070220410.4173-100000@Huntington-Beach.Blue-Labs.org> <20010108011308.A2575@metastasis.f00f.org> <200101071201.EAA01790@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101071201.EAA01790@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 07, 2001 at 04:01:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 04:01:04AM -0800, David S. Miller wrote:
>    Date:   Mon, 8 Jan 2001 01:13:08 +1300
>    From: Chris Wedgwood <cw@f00f.org>
> 
>    OK, I'm a liar -- bind does handle this. Cool.
> 
> Standard BSD allows it, what do you expect :-)
> 
>    This is good news, because it means there is a precedent for multiple
>    addresses on a single interface so we can kill the <ifname>:<n>
>    syntax in favor of the above which is cleaner of more accurately
>    represents what is happening.
> 
> If this is really true, 2.5.x is an appropriate time to make
> this, no sooner.

I think it would be better to keep it. The ifa based alias interface 
emulation adds minor overhead (currently it's only a few lines of code,
assuming we need named if addresses for other reasons too, which we do) 
and removing it it would break a lot of configuration scripts etc., for 
no really good gain. 


-Andi



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
