Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRARAli>; Wed, 17 Jan 2001 19:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131340AbRARAlW>; Wed, 17 Jan 2001 19:41:22 -0500
Received: from [129.94.172.186] ([129.94.172.186]:28655 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130117AbRARAk6>; Wed, 17 Jan 2001 19:40:58 -0500
Date: Wed, 17 Jan 2001 19:33:23 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Daniel Phillips <phillips@innominate.de>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Rohland <cr@sap.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <3A5B401F.9D4BCBDF@innominate.de>
Message-ID: <Pine.LNX.4.31.0101171932460.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Daniel Phillips wrote:

> Call it 'pinned'... the pinned list would have pages with use
> count = 2 or more.  A page gets off the pinned list when its use
> count goes to 1 in put_page.

I don't even want to start thinking about how this would
screw up the (already fragile) page aging balance...

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
