Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129625AbQKRQ6T>; Sat, 18 Nov 2000 11:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbQKRQ6J>; Sat, 18 Nov 2000 11:58:09 -0500
Received: from 213-1-125-95.btconnect.com ([213.1.125.95]:26498 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129684AbQKRQ5v>;
	Sat, 18 Nov 2000 11:57:51 -0500
Date: Sat, 18 Nov 2000 16:29:51 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 mm init cleanup
In-Reply-To: <3A16ACD6.71BAF564@didntduck.org>
Message-ID: <Pine.LNX.4.21.0011181628220.1270-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000, Brian Gerst wrote:

> Patch against test11.  This patch moves the setting of %cr4 out of the
> loops and makes the code a bit more readable.  Tested with standard
> pagetables, PSE, and PAE.
> 
> 

Brian,

while you were there, so close to paging_init() why not also correct the
wrong comment at the top of the function? It talks about 0-4M pagetables
whereas we really setup (see head.S) 0-8M.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
