Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbQLMCxJ>; Tue, 12 Dec 2000 21:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbQLMCwt>; Tue, 12 Dec 2000 21:52:49 -0500
Received: from [195.166.20.93] ([195.166.20.93]:13322 "EHLO
	frumious.unidec.co.uk") by vger.kernel.org with ESMTP
	id <S129846AbQLMCwl>; Tue, 12 Dec 2000 21:52:41 -0500
Date: Wed, 13 Dec 2000 02:21:34 GMT
From: root <root@frumious.unidec.co.uk>
Message-Id: <200012130221.eBD2LYs07572@frumious.unidec.co.uk>
To: torrey.hoffman@myrio.com
Subject: Re: National Semiconductor DP83815 ethernet driver?
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From searching Google, I know some sort of driver exists. In July, Adam J.
>Richter (adam@yggdrasil.com) posted a 2.2.16 driver he obtained from Dave
>Gotwisner at Wyse Technologies. And Tim Hockin mentioned that he was using
>an NSC driver, but had made some minor modifications.

This one has a very murky past. Adam & I have both received the same
driver from within NatSemi, which turned out to be a rehash of the
driver originally written by Donald Becker (with his name and the GPL
license removed...). It should be noted that this wasn't "written" by
NatSemi themselves, but by a company called TeamF1.

Since then Donald's original driver (natsemi.c) has been folded into the
2.4 kernel, and I can happily report works well with 2.2 as well. It's
certainly a lot better than the dp83815.c program, which I found had
the tendency to hang the machine completely in high traffic (well, if
you count ftping from a host on the same 10Mb half duplex network as
high load ;).

john

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
