Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRACXcL>; Wed, 3 Jan 2001 18:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131367AbRACXcB>; Wed, 3 Jan 2001 18:32:01 -0500
Received: from anime.net ([63.172.78.150]:27920 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129370AbRACXbv>;
	Wed, 3 Jan 2001 18:31:51 -0500
Date: Wed, 3 Jan 2001 15:32:46 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <mark@itsolve.co.uk>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101040037200.21774-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.30.0101031528180.32282-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Dan Aloni wrote:
> Anyway, while it is agreed that you can't completely eliminate exploits,
> it is recommended that, it should be at least harder to create them, maybe
> it can even minimize the will to write them.

The argument against these sort of protection mechanisms seems to be "well
its not perfect, so we shouldnt have it at all".

Lets use that argument against uid/gid then. Since it's impossible to
protect against exploits, let's dispose of uid/gid entirely and run
everything as root ;-)

"stack guarding is a false sense of security". Well, so is ipchains, so
lets discard that as well...?

Really, these arguments cut both ways. If you are going to argue against
something because it's not perfect, you should be aware that you're
arguing against other kernel protection mechanisms also.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
