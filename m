Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129221AbQKIAI7>; Wed, 8 Nov 2000 19:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQKIAIt>; Wed, 8 Nov 2000 19:08:49 -0500
Received: from humbolt.geo.uu.nl ([131.211.28.48]:60423 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S129057AbQKIAIj>; Wed, 8 Nov 2000 19:08:39 -0500
Date: Thu, 9 Nov 2000 01:08:19 +0100 (CET)
From: Rik van Riel <riel@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Szabolcs Szakacsits <szaka@f-secure.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: Looking for better VM
In-Reply-To: <Pine.LNX.3.96.1001108172338.7153A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.05.10011090106520.23541-100000@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Mikulas Patocka wrote:

> BTW. Why does your OOM killer in 2.4 try to kill process that mmaped
> most memory? mmap is hamrless. mmap on files can't eat memory and
> swap.

Because the thing is too stupid to take that into
consideration? :)

Btw, if your mmap()ed file still takes 1GB of memory,
you have 1GB of freeable memory left and you shouldn't
be out of memory ... or should you??

regards,

Rik
--
The Internet is not a network of computers. It is a network
of people. That is its real strength.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
