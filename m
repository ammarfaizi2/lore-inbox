Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLWXJS>; Sat, 23 Dec 2000 18:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLWXJI>; Sat, 23 Dec 2000 18:09:08 -0500
Received: from hera.cwi.nl ([192.16.191.1]:9928 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129458AbQLWXIy>;
	Sat, 23 Dec 2000 18:08:54 -0500
Date: Sat, 23 Dec 2000 23:38:06 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Manfred <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu, torvalds@transmeta.com
Subject: Re: minor bugs around fork_init
Message-ID: <20001223233806.A886@veritas.com>
In-Reply-To: <3A44D3F3.522AD08A@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A44D3F3.522AD08A@colorfullife.com>; from manfred@colorfullife.com on Sat, Dec 23, 2000 at 05:33:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 05:33:55PM +0100, Manfred wrote:

> * get_pid causes a deadlock when all pid numbers are in use.
> In the worst case, only 10900 threads are required to exhaust
> the 15 bit pid space.

Yes. I posted a patch for 31-bit pids once or twice.
There is no great hurry, but on the other hand, it is always
better to make these changes long before it is really urgent.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
