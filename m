Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSKUWNf>; Thu, 21 Nov 2002 17:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSKUWNf>; Thu, 21 Nov 2002 17:13:35 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:57570 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S264972AbSKUWNe>;
	Thu, 21 Nov 2002 17:13:34 -0500
Message-ID: <1037917231.3ddd5c2f5d98a@webmail.jordet.nu>
Date: Thu, 21 Nov 2002 23:20:31 +0100
From: Stian Jordet <liste@jordet.nu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unsupported AGP-bridge on VIA VT8633
References: <1037916067.813.7.camel@chevrolet.hybel> <20021121221134.GA25741@suse.de>
In-Reply-To: <20021121221134.GA25741@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Jones <davej@codemonkey.org.uk>:

> On Thu, Nov 21, 2002 at 11:01:07PM +0100, Stian Jordet wrote:
>  > Based on agpgart interface v0.99 (c) Jeff Hartmann
>  > agpgart: Maximum main memory to use for agp memory: 439M
>  > agpgart: Unsupported Via chipset (device id: 3091), you might want to
>  > try agp_try_unsupported=1.
>  > agpgart: no supported devices found.
>  > 
>  > I have tried with agp_try_unsupported=1, but no luck.
> 
> You tried agp_try_unsupported=1 as a modprobe argument,
> not as a boot time argument right ?
> Quite a few people seem to fall into this trap.
> 
> When I get chance, I'll make that a boottime arg too.

You were not really clear here. I tried it as a boot-time argument, because I
have agp-support compiled in. But I guess I could and should try it as a module.
I'll do that now. But why do I have to use agp_try_unsupported=1?

Regards,
Stian Jordet
