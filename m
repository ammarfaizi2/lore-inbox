Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289064AbSANVKm>; Mon, 14 Jan 2002 16:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSANVK1>; Mon, 14 Jan 2002 16:10:27 -0500
Received: from ns.suse.de ([213.95.15.193]:28434 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289057AbSANVId>;
	Mon, 14 Jan 2002 16:08:33 -0500
Date: Mon, 14 Jan 2002 22:08:32 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
Message-ID: <Pine.LNX.4.33.0201142208070.21352-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 03:38:44PM -0500, Eric S. Raymond wrote:

 > Right now, neither lsmod nor the boot time messages  necessarily give you that
 > information.

 One of the great things about Linux (or at least I think so) kernel
 is it's incredibly verbose startup.
 If you have a configured network, boot messages WILL tell you
 what driver is controlling that card.  If built as a module
 lsmod WILL tell you.

 > /var/log/dmesg contains no message from the NIC on my motherboard.

 Then that's a driver issue. What NIC ?

 > And going from the driver to the config symbol isn't trivial even
 > if you *have* the lsmod or dmesg information.

 Then we need better descriptions in the CML2 rules.

 > And anyway there are settings you can't even recover by looking at the
 > hardware, such as whether KHTTPD or BSD process accounting were turned
 > on.

 ls /proc/sys/net/khttpd
 ls /proc/sys/kernel/acct

 > Sure, Melvin could remember a whole bunch of state, or a whole bunch
 > of rules for reconstructing it. But isn't sweating that kind of detail
 > exactly what *computers* are for?

 If Melvin really does have a mind like a sieve,he'd  put .config
 somewhere sensible after building a kernel.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

