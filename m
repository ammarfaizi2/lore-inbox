Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbRBCOgV>; Sat, 3 Feb 2001 09:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129968AbRBCOgL>; Sat, 3 Feb 2001 09:36:11 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:64524 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129880AbRBCOfw>; Sat, 3 Feb 2001 09:35:52 -0500
Date: Sat, 3 Feb 2001 15:33:10 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Robert H. de Vries" <rhdv@rhdv.cistron.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] POSIX timers for 2.4.1
Message-ID: <20010203153310.B30376@pcep-jamie.cern.ch>
In-Reply-To: <01020313391300.01904@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01020313391300.01904@calvin>; from rhdv@rhdv.cistron.nl on Sat, Feb 03, 2001 at 01:39:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert H. de Vries wrote:
> Hi Linus,
> c. setitimer() can be used only once in a given process, you can have
>    up to 32 (configurable) POSIX timers at the same time in your process.

Why is there a limit?  With such a small limit, any library that wants
to use its own private timers is going to have to agree a way to
multiplex with other libraries, and you're back to setitimer().

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
