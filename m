Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSJCUIm>; Thu, 3 Oct 2002 16:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSJCUIm>; Thu, 3 Oct 2002 16:08:42 -0400
Received: from relay.snowman.net ([63.80.4.38]:58116 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S261311AbSJCUIk>;
	Thu, 3 Oct 2002 16:08:40 -0400
From: nick@snowman.net
Date: Thu, 3 Oct 2002 16:14:10 -0400 (EDT)
To: "David S. Miller" <davem@redhat.com>
cc: linux_learning@yahoo.co.uk, linux-kernel@vger.kernel.org,
       linux-c-programming@vger.kernel.org
Subject: Re: this code does not get called in dev.c so do we need it?
In-Reply-To: <20021002.171042.42890215.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0210031613500.12220-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this is a dumb question, but why arn't there any in-tree
drivers with support for this?  Is it too ugly to merge?
	Nick

On Wed, 2 Oct 2002, David S. Miller wrote:

> 
> Fast routing, although not implemented in any in-tree drivers,
> does get used by some people who have hacked up drivers to support
> this.
> 
> It allows IPv4 routing to occur right at the level of the device
> driver, it directly pushes an input packet to the output routine
> of the destination device all without leaving the driver.
> 
> This code is used.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

