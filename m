Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <972117-5431>; Fri, 10 Jul 1998 12:45:29 -0400
Received: from haymarket.ed.ac.uk ([129.215.128.53]:53341 "EHLO haymarket.ed.ac.uk" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <972177-5431>; Fri, 10 Jul 1998 12:16:58 -0400
Date: Fri, 10 Jul 1998 14:34:32 +0100
Message-Id: <199807101334.OAA00877@dax.dcs.ed.ac.uk>
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Bill Hawes <whawes@star.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, ganesh.sittampalam@magd.ox.ac.uk, Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>
Subject: Re: Progress! was: Re: Yet more VM writable swap-cached pages
In-Reply-To: <35A57732.A7B5DFF@star.net>
References: <Pine.LNX.3.95.980709184611.6873C-100000@fishy> <199807100042.BAA07833@dax.dcs.ed.ac.uk> <35A57732.A7B5DFF@star.net>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Thu, 09 Jul 1998 22:06:42 -0400, Bill Hawes <whawes@star.net> said:

> In my searches for the problem I had overlooked the interaction
> between the PRESENT and PROT_NONE bits.

You're not the only one!

> Hopefully any remaining swap bugs won't be so hard to track down ...

Yep.  Ingo and I have been doing a bunch of swapping stress tests with
no problems so far, so we're hoping that any other problems that turn
up will be due to the use of specific features like PROT_NONE and
won't be problems in the underlying swap mechanisms.  Well, we can
hope, can't we?  :)

--Stephen


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
