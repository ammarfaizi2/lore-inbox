Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132002AbRANRrB>; Sun, 14 Jan 2001 12:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132611AbRANRqw>; Sun, 14 Jan 2001 12:46:52 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:53510 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S132002AbRANRqq>; Sun, 14 Jan 2001 12:46:46 -0500
Date: Sun, 14 Jan 2001 17:46:37 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <93r8fl$2nm$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101141741390.18663-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2001, Linus Torvalds wrote:

> You miss _entirely_ the reason why "get_module_symbol()" was removed,
> and why I will not _ever_ accept it coming back.
> 
> Hint #1: get_MODULE_symbol().
> Hint #2: compiled in functionality.

Er,... forgive me if I'm being overly dense here, but I can't see anything 
fundamentally wrong in the above that wouldn't be fixed with a 
judicious application of s/module_//

But I have no particular attachment to it. All I'm asking for is a way to
avoid having init order dependencies where previously there was no need
for them, by having a way to put entries in the inter_module_get() table
at compile time.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
