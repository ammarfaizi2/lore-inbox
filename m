Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154839-31090>; Tue, 22 Dec 1998 23:25:40 -0500
Received: from [203.35.221.8] ([203.35.221.8]:1486 "EHLO thompson.unifi.com.au" ident: "ssmith") by vger.rutgers.edu with ESMTP id <155254-31090>; Tue, 22 Dec 1998 21:28:04 -0500
Date: Wed, 23 Dec 1998 14:33:34 +1100
Message-Id: <199812230333.OAA20556@thompson.unifi.com.au>
From: Steve Smith <ssmith@unifi.com.au>
To: linux-kernel@vger.rutgers.edu
In-reply-to: <19981223005615Z155003-31090+15714@vger.rutgers.edu> (owner-linux-kernel-digest@vger.rutgers.edu)
Subject: [Silliness] Re: Wanted: Secure-delete utility for Linux
References: <19981223005615Z155003-31090+15714@vger.rutgers.edu>
Sender: owner-linux-kernel@vger.rutgers.edu

>> IMHO the name /dev/one would be a bad idea. Becouse this could mean an
>> integer one which is 00000001 for 8-bit, 0000000000000001 for 16-bit, and
>> so on.
>> 
>> I don't know a better name - but IMHO /dev/one would be a bad name.
>
> /dev/minusone ?

Wouldn't /dev/ff be more appropriate??  But then /dev/zero is
ambiguous, possibly meaning "0".  This should be /dev/00

But what about other characters?

People, we seem to have uncovered a fundamental problem in the Kernel
pseudo-devices.  *Not everything is covered!!*  This must be rectified
before 2.2!

First we need /dev/00 - ff and, to avoid any ambiguity,
/dev/\"[A-Za-z0-9]\".  But what of strings?  How to generate strings??

At first I thought that we must generate a device driver for every
possible sentence (with international support of course), until I
recalled the /dev/ptmx device.

Therefore, I propose a new device: /dev/monkeys.  This
infinite-monkeys simulator will supply all possible combinations of
strings, and selecting the required one is left to user space
programs.  Elegant, no?

It also has bandwidth saving advantages.  Why traipse all the way
across the net to Project Gutenberg when all the works of Shakespeare
are in your /dev directory?

I shall start on this project as soon as the pain in my head subsides.

Steve

PS.  "man tr" everybody

PPS.  Sorry.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
