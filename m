Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUAZHO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 02:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbUAZHO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 02:14:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:224 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264936AbUAZHO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 02:14:57 -0500
Subject: Re: [PATCH] sungem: add support for G5 PowerMac, some PM fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040125.230102.71560587.davem@redhat.com>
References: <1074750642.974.109.camel@gaston>
	 <20040121220823.63d46968.davem@redhat.com>
	 <1074813192.949.121.camel@gaston>
	 <20040125.230102.71560587.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1075101232.5659.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 18:13:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-26 at 18:01, David S. Miller wrote:
>    From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>    Date: Fri, 23 Jan 2004 10:13:12 +1100
> 
>    Anyway, here's the fixed version.
> 
> Applied, thanks.  This one might have to wait for 2.6.3-pre1 though
> for merging.

That's fine, the rest of the PowerMac updates are waiting for 2.6.3 too.
>    The 2.4 backport will come next week hopefully when I'll walk
>    through all my pending 2.4 stuffs, I want to dbl check a few things
>    in it first (and I'm not yet 100% certain I will merge the G5
>    support in 2.4 upstream anyway).
> 
> You should be able to literally copy the 2.6.x driver into the 2.4.x
> tree with perhaps only a one liner or two (if that).

Yes. I'll do that along with other things I need to backport.

>    the new PCI ID isn't yet in Linus tree, but it's in the patches
>    I'm currently sending to Andrew.
> 
> I'd prefer in the future you not do it this way, just give it
> instead within the driver update so that you patch by itself
> stands alone.

Ok.

Ben.


