Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSKDQt2>; Mon, 4 Nov 2002 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSKDQt2>; Mon, 4 Nov 2002 11:49:28 -0500
Received: from 208-135-136-018.customer.apci.net ([208.135.136.18]:19725 "EHLO
	blessed") by vger.kernel.org with ESMTP id <S261561AbSKDQt1>;
	Mon, 4 Nov 2002 11:49:27 -0500
Date: Mon, 4 Nov 2002 10:55:50 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
X-X-Sender: jbm@blessed
To: dark side <ognen@kc.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: irq_vectors.h (where is it)?
In-Reply-To: <049d826450004b2FE6@mail6.kc.rr.com>
Message-ID: <Pine.LNX.4.44.0211041054580.29137-100000@blessed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grep  -r is your friend

it's in arch/i386/mach-generic/

see also the gcc lines whizzing past during compile =)
--
/jbm, but you can call me Josh. Really, you can!
 "What's a metaphor?" "For sheep to graze in"
7958 1C1C 306A CDF8 4468  3EDE 1F93 F49D 5FA1 49C4


On Sun, 3 Nov 2002, dark side wrote:

> Hi,
>
> the file /usr/src/linux-2.5.45/include/asm-i386/irq.h #includes the file
> "irq_vectors.h" which is not in the same directory. Is this in error?
> If not, sorry for wasting your time.
>
> Cheers,
> Ognen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

