Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVKMLJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVKMLJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 06:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVKMLJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 06:09:39 -0500
Received: from [85.8.13.51] ([85.8.13.51]:58265 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932473AbVKMLJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 06:09:39 -0500
Message-ID: <43771EEB.9080808@drzeus.cx>
Date: Sun, 13 Nov 2005 12:09:31 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Register interrupt handler when net device is registered.
 Avoids missing
References: <E1Eb7yZ-00064D-00@gondolin.me.apana.org.au>
In-Reply-To: <E1Eb7yZ-00064D-00@gondolin.me.apana.org.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Pierre Ossman <drzeus@drzeus.cx> wrote:
> 
>>interrupts if the interrupt mask gets out of sync.
> 
> 
> What about fixing the interrupt mask instead rather than keeping
> the IRQ handler registered all time?
> 

The best solution would be to put the device in the same state as it
normally is when it is down. But I do not know the network subsystem or
the 8139c+ well enough to do this myself.

> BTW, you should submit this via Jeff Garzik <jgarzik@pobox.com> and
> netdev@vger.kernel.org.
> 

I did. I also cc:d the author of the suspend code. No one answered.

Rgds
Pierre
