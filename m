Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbQL1WQq>; Thu, 28 Dec 2000 17:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131950AbQL1WQg>; Thu, 28 Dec 2000 17:16:36 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:44026 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131455AbQL1WQ0>; Thu, 28 Dec 2000 17:16:26 -0500
Date: Thu, 28 Dec 2000 19:45:52 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Ari Heitner <aheitner@andrew.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: sharing text segments of all programs
In-Reply-To: <Pine.SOL.3.96L.1001228000737.3482B-100000@unix13.andrew.cmu.edu>
Message-ID: <Pine.LNX.4.21.0012281943510.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Ari Heitner wrote:

> this has to be a dumb idea

Not really, you're just 8 (9?) years too late...

> The question is, why shouldn't it be possible to share the text
> segments of *all* running programs?

Linux uses shared mmap() for "loading" executables (well,
they're just mapped and demand-loaded as page faults come
in), which happens to give exactly the behaviour that's on
your wish list ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
