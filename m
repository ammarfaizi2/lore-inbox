Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbRGBPER>; Mon, 2 Jul 2001 11:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbRGBPEH>; Mon, 2 Jul 2001 11:04:07 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:54409 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S265065AbRGBPD5>; Mon, 2 Jul 2001 11:03:57 -0400
Date: Mon, 2 Jul 2001 16:03:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Riley Williams <rhw@memalpha.cx>
Cc: Keith Owens <kaos@ocs.com.au>, Adam J Richter <adam@yggdrasil.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010702160351.B28778@flint.arm.linux.org.uk>
In-Reply-To: <20010702104134.A28123@flint.arm.linux.org.uk> <Pine.LNX.4.33.0107021326340.13114-100000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107021326340.13114-100000@infradead.org>; from rhw@MemAlpha.CX on Mon, Jul 02, 2001 at 01:40:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 01:40:25PM +0100, Riley Williams wrote:
> Who's sent a patch to Linus? I haven't, and don't intend to do so.

The way this thread is progressing, it won't take much to get there.  We've
already propagated the inaccuracies in the "example" depencencies by 3 or
more mails.  I'm just trying to stop it before someone forgets that it's
just an example.

> First, why is it "far too late" as you put it? It won't be the first
> time config vars have been renamed, and it's unlikely to be the last
> either...

I'm not going to cause disruption across the board to lots of people just
because someone wants to keep the length of the symbols down.

If you really do want to do this change, then I suggest that you get in
touch with Nicolas Pitre and discuss it with him.  When you come to a
conclusion, its not as simple as patching the kernel.  You need to
update the database at www.arm.linux.org.uk/developer/machines/ to
reflect the new symbols _at the same time_ that you change them in
everyones tree, since anyone can pull down a new copy of the symbols
from the database at any time.

IMHO, a logistical nightmare to perform.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

