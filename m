Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129157AbQKARa3>; Wed, 1 Nov 2000 12:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129253AbQKARaU>; Wed, 1 Nov 2000 12:30:20 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:52726 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129157AbQKARaL>; Wed, 1 Nov 2000 12:30:11 -0500
Date: Wed, 1 Nov 2000 15:29:45 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: matthew <matthew@mattshouse.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <20001101171321.A8815@bart.dev.sportingbet.com>
Message-ID: <Pine.LNX.4.21.0011011527110.11112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Sean Hunter wrote:

> Yup.  What seems to have happened is that waking up 1800
> processes at once has caused the box to thrash so hard it is
> taking ages for any one process to get enough scheduler time to
> clean itself up and exit.
> 
> I guess we may need a thrash preventer that slows things down
> enough for each process to get a healthy bite of the cherry.

That's the idea, yes. The current (highly experimental) code
to do this is very ugly, though, and it doesn't quite work
the way it should either ;)

I hope to have it cleaned up and available as an add-on patch
soon.

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
