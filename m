Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137093AbRAHGNh>; Mon, 8 Jan 2001 01:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137095AbRAHGNT>; Mon, 8 Jan 2001 01:13:19 -0500
Received: from mail.linux.com ([198.186.203.59]:28676 "EHLO mail.i.linux.com")
	by vger.kernel.org with ESMTP id <S137093AbRAHGNK>;
	Mon, 8 Jan 2001 01:13:10 -0500
Date: Sun, 7 Jan 2001 22:13:06 -0800 (PST)
From: Blu3Viper <david@linux.com>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, cw@f00f.org, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <20010108063214.A29026@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0101072208330.7551-100000@shiftq.linux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Andi Kleen wrote:
> > If this is really true, 2.5.x is an appropriate time to make
> > this, no sooner.
> 
> I think it would be better to keep it. The ifa based alias interface 
> emulation adds minor overhead (currently it's only a few lines of code,
> assuming we need named if addresses for other reasons too, which we do) 
> and removing it it would break a lot of configuration scripts etc., for 
> no really good gain. 

How about turning it out with a legacy/deprecated CONFIG_ option so we can
prepare people. For now it can default to enabled.

-d

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
