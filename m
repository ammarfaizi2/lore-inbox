Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRARAiS>; Wed, 17 Jan 2001 19:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130077AbRARAiJ>; Wed, 17 Jan 2001 19:38:09 -0500
Received: from [129.94.172.186] ([129.94.172.186]:5615 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129884AbRARAh7>; Wed, 17 Jan 2001 19:37:59 -0500
Date: Thu, 18 Jan 2001 08:15:50 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Vlad Bolkhovitine <vladb@sw.com.sg>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: mmap()/VM problem in 2.4.0
In-Reply-To: <3A5EFB40.6080B6F3@sw.com.sg>
Message-ID: <Pine.LNX.4.31.0101180814080.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.31.0101180814082.31432@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Vlad Bolkhovitine wrote:

> You can see, mmap() read performance dropped significantly as
> well as read() one raised. Plus, "interactivity" of 2.4.0 system
> was much worse during mmap'ed test, than using read()
> (everything was quite smooth here). 2.4.0-test7 was badly
> interactive in both cases.

Could have to do with page_launder() ... I'm working on
streaming mmap() performance here and have been working
on this for a week now (amongst other things).

I'll clean up my code soon and will make it available on
my home page asap. When we're certain it works I'll submit
some of it to Linus.

regards,

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
