Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131241AbRAENfw>; Fri, 5 Jan 2001 08:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbRAENfl>; Fri, 5 Jan 2001 08:35:41 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:12047 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131190AbRAENfW>; Fri, 5 Jan 2001 08:35:22 -0500
Date: Fri, 5 Jan 2001 08:36:25 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Network oddity.... 
In-Reply-To: <200101050008.BAA14222@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.31.0101050836060.27543-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Rogier Wolff wrote:

>Date: Fri, 5 Jan 2001 01:08:49 +0100 (MET)
>From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
>To: linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=US-ASCII
>Subject: Network oddity....
>
>
>Hi all,
>
>I have a server, and it reports ("netstat -a")
>
>tcp        0      0 server:ssh    client:1022 SYN_RECV
>
>This sounds normal right?
>
>However there are 79 of these lines in the netstat output. Not normal!
>
>A TCP connection is identified by the 12 bytes source IP, dest IP,
>source port, dest port. Right? Then as far as I can see, these should
>all refer to the SAME socket. (yes, they all refer to server:ssh, and
>client: 1022!)
>
>Oh, this situation seems to continue: it sends a syn-ack and then the
>client replies with a reset. This goes on and on. I'm going to make
>the client disappear, and hope that this makes the number of these
>connections go away.
>
>Kernel is 2.2.13. That was "fresh" when the system was booted. Yes,
>that's over 14 months ago.

Someone synflooding you perhaps?


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

If you think C++ is not overly complicated, just what is a protected
abstract virtual base pure virtual private destructor, and when
was the last time you needed one?
  -- Tom Cargill, C++ Journal, Fall 1990.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
