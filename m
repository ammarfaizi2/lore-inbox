Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270309AbRHHEQo>; Wed, 8 Aug 2001 00:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270310AbRHHEQe>; Wed, 8 Aug 2001 00:16:34 -0400
Received: from [209.195.52.30] ([209.195.52.30]:3104 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S270309AbRHHEQV>;
	Wed, 8 Aug 2001 00:16:21 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ben Ford <ben@kalifornia.com>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Date: Tue, 7 Aug 2001 19:59:11 -0700 (PDT)
Subject: Re: summary Re: encrypted swap
In-Reply-To: <3B70B241.40908@kalifornia.com>
Message-ID: <Pine.LNX.4.33.0108071957170.3450-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

only if you can guarenty that there is no way to avoid wiping it even if
this is the 2nd (or 3rd) hard drive (and what about how swap drives that
get added to a system after boot)

also this had better be a configuration option. I don't want to wait for
2g of swap space to be wiped when I boot by webserver (which defeates my
previous requirement)

David Lang

 On Tue, 7 Aug 2001, Ben Ford wrote:

> Date: Tue, 07 Aug 2001 20:30:09 -0700
> From: Ben Ford <ben@kalifornia.com>
> To: David Wagner <daw@mozart.cs.berkeley.edu>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: summary Re: encrypted swap
>
> David Wagner wrote:
>
> >You missed some scenarios.  Suppose I run a server that uses crypto.
> >If swap is unencrypted, all the session keys for the past year might
> >be laying around on swap.  If swap is encrypted, only the session keys
> >since the last boot are accessible, at most.  Therefore, using encrypted
> >swap clearly reduces the impact of a compromise of your machine (whether
> >through theft or through penetration).  This is a good property.
> >
> Wiping swap on boot will achieve the same effect.
>
> -b
>
> --
> Please note - If you do not have the same beliefs as we do, you are
> going to burn in Hell forever.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
