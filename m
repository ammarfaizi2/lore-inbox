Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270131AbRHGHuj>; Tue, 7 Aug 2001 03:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270132AbRHGHu2>; Tue, 7 Aug 2001 03:50:28 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:5138 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270131AbRHGHuU>; Tue, 7 Aug 2001 03:50:20 -0400
Message-ID: <3B6F9D78.412AB717@idb.hist.no>
Date: Tue, 07 Aug 2001 09:49:12 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Steve VanDevender <stevev@efn.org>, rmack@mackman.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>
		<Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net> <15215.27296.959612.765065@localhost.efn.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve VanDevender wrote:
> 
> Justin Guyett writes:
>  > On Tue, 7 Aug 2001, David Spreen wrote:
>  >
>  > > I was just searching for swap-encryption-solutions in the lkml-archive.
>  > > Did I get the point saying ther's no way to do swap encryption
>  > > in linux right now? (Well, a swapfile in an encrypted kerneli
>  > > partition r something like that is not really what I want to
>  > > do I think).
>  >
>  > What's the benefit?  
[...] 
> It does prevent one means of recovering possibly security-critical
> information for attackers who do have physical access to the machine.

The encrypted swap device protects against the guy who steals the
harddisk.  It doesn't really protect against someone with physical
access though.

I can remove RAM live, and read it in another device.  Or replace
the cpu with an interface that simply reads all the RAM
addresses.  Sure, I'll leave a crashed machine, but I have
your precious data.  A smp machine might even survive the
cpu replacement and continue with one less cpu and
a frozen process.

Having the RAM contents will of course provide what I need to
decrypt the swap device and all mounted filesystems too.



Helge Hafting
