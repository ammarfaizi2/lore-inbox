Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132964AbRAHWGC>; Mon, 8 Jan 2001 17:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRAHWFw>; Mon, 8 Jan 2001 17:05:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3468 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132964AbRAHWFm>;
	Mon, 8 Jan 2001 17:05:42 -0500
Date: Mon, 8 Jan 2001 13:48:08 -0800
Message-Id: <200101082148.NAA21738@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jes@linuxcare.com
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <d366jp4sin.fsf@lxplus015.cern.ch> (message from Jes Sorensen on
	08 Jan 2001 22:56:48 +0100)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net> <d366jp4sin.fsf@lxplus015.cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jes Sorensen <jes@linuxcare.com>
   Date: 08 Jan 2001 22:56:48 +0100

   I don't think it's too much to ask that one actually tries to
   communicate with an author of a piece of code before making such
   major changes and submitting them opting for inclusion in the
   kernel.

Jes, I have not submitted this for inclusion into the kernel.

This is the "everyone, including driver authors, take a look"
part of the development process.

We _had_ to change some drivers to show how to support this
new SKB api for transmit sg+csum support.  If you can think of
a way for us to effectively do this work without changing at least a
few drivers as examples (and proof of concept), please let us know.

In the process we hit real bugs in your driver, and tried to deal
with them as best we could so that we could continue testing and
debugging our own code.

As a side note, as much as you may hate some of Alexey's changes to
your driver, several things he does fixes long standing real bugs in
the Acenic driver that you've been papering over with workarounds
for quite some time.  I would even go so far as to say that in many
regards Alexey understands the Acenic much better than you, and you
would be wise to work with Alexey and not against him.  Thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
