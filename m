Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbSKPHI3>; Sat, 16 Nov 2002 02:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267240AbSKPHI3>; Sat, 16 Nov 2002 02:08:29 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28164 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267239AbSKPHI2>;
	Sat, 16 Nov 2002 02:08:28 -0500
Date: Sat, 16 Nov 2002 08:15:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARAM 2/4
Message-ID: <20021116071509.GC553@alpha.home.local>
References: <20021115222725.258EC2C129@lists.samba.org> <3DD57A84.2070805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD57A84.2070805@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 05:51:48PM -0500, Jeff Garzik wrote:
[snip] 
> 2) "proper", converted-to-Rusty-style driver code is going to have
> 
> 	MODULE_blah
> 	MODULE_foo
> 	MODULE_bar
> 	PARAM
> 
> You think that looks good??
> 
> 3) modules a.k.a. drivers are going to be the more common users of this 
> interface.
[snip] 
> PARAM is ugly in drivers, and way too generic.

Why not DRIVER_PARAM in this case ? It's enough explicit and not misleading.
I too agree that PARAM is a bit too generic.

Cheers,
Willy

