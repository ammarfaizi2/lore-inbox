Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129964AbRBCRly>; Sat, 3 Feb 2001 12:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130148AbRBCRlp>; Sat, 3 Feb 2001 12:41:45 -0500
Received: from fungus.teststation.com ([212.32.186.211]:54460 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129964AbRBCRld>; Sat, 3 Feb 2001 12:41:33 -0500
Date: Sat, 3 Feb 2001 18:41:25 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <T.Stewart@student.umist.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DFE-530TX with no mac address
In-Reply-To: <3A7C3C6E.7296.82EE32@localhost>
Message-ID: <Pine.LNX.4.30.0102031824030.14465-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001 T.Stewart@student.umist.ac.uk wrote:

> I noticed that the mac address was stored in the registers and 
> eprom. I guess it would not be as easy as just writing the mac 
> back in the blank eprom and registers?

What my changed via-diag tries to do is to tell the chip to reload things
from the eeprom (note that the diag program doesn't actually list the
eeprom contents).

You can always try writing all the registers with "good" values.


> Is there a reset 'thing' for thses chips, that sets them back to 
> factory tests (like switching them off)?
[snip]
> So.....How do I go about playing this game?

You find the reset "thing". Maybe there is better documentation somewhere.
Maybe your bios allows you to reset something on reboots.

The pdf document has a few things that you can play with, SRST, INIT, 
STRT.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
