Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154586-14823>; Sat, 1 May 1999 05:56:53 -0400
Received: by vger.rutgers.edu id <153993-14823>; Sat, 1 May 1999 05:53:22 -0400
Received: from [207.104.6.26] ([207.104.6.26]:2385 "EHLO piglet.twiddle.net" ident: "davem") by vger.rutgers.edu with ESMTP id <154063-14823>; Sat, 1 May 1999 05:53:00 -0400
Date: Sat, 1 May 1999 03:40:14 -0700
Message-Id: <199905011040.DAA24934@piglet.twiddle.net>
From: David Miller <davem@twiddle.net>
To: alex.buell@tahallah.demon.co.uk
CC: hpa@transmeta.com, linux-kernel@vger.rutgers.edu
In-reply-to: <Pine.LNX.4.10.9905011108010.2314-100000@tahallah.demon.co.uk> (message from Alex Buell on Sat, 1 May 1999 11:11:21 +0100 (GMT))
Subject: Re: 64bit port
References: <Pine.LNX.4.10.9905011108010.2314-100000@tahallah.demon.co.uk>
Reply-To: davem@redhat.com
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: Sat, 1 May 1999 11:11:21 +0100 (GMT)
   From: Alex Buell <alex.buell@tahallah.demon.co.uk>

   Ie. on loading of a binary could quickly scan it for illegal
   sequences and overwrite with NOPs, then execute it. Of course, this
   doesn't cater for things that does J-I-T compilation & execution
   though.

You roughly have described how we hope to work around it.

IRIX does something very similar to work around cpu lockup
bugs on early MIPS r4k parts.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
