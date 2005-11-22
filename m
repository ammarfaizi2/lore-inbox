Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVKVJUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVKVJUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVKVJUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:20:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:940 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964857AbVKVJUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:20:50 -0500
X-Authenticated: #428038
Date: Tue, 22 Nov 2005 10:20:47 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122092047.GD16295@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121124544.9e502404.diegocg@gmail.com> <9611fa230511210619l208b10a8w77aedaa249345448@mail.gmail.com> <200511211252.04217.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511211252.04217.rob@landley.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Rob Landley wrote:

> On Monday 21 November 2005 08:19, Tarkan Erimer wrote:
> > On 11/21/05, Diego Calleja <diegocg@gmail.com> wrote:
> > If It happenned, Sun or someone has port it to linux.
> > We will need some VFS changes to handle 128 bit FS as "Jörn ENGEL"
> > mentionned previous mail in this thread. Is there any plan or action
> > to make VFS handle 128 bit File Sytems like ZFS or future 128 bit
> > File Systems ? Any VFS people reply to this, please?
> 
> I believe that on 64 bit platforms, Linux has a 64 bit clean VFS.  Python says 
> 2**64 is 18446744073709551616, and that's roughly:
> 18,446,744,073,709,551,616 bytes
> 18,446,744,073,709 megs

  18,446,744,073,710 Mbytes (round up)

> 18,446,744,073 gigs
> 18,446,744 terabytes
> 18,446 ...  what are those, petabytes?

  18,447 Pbytes, right.

> 18 Really big lumps of data we won't be using for a while yet.

18 Exabytes, indeeed.

Sun decided not to think about sizing for a longer while, and looking at
how long ufs has been around, Sun may have the better laugh in the end.

> Sun is proposing it can predict what storage layout will be efficient for as 
> yet unheard of quantities of data, with unknown access patterns, at least a 
> couple decades from now.  It's also proposing that data compression and 
> checksumming are the filesystem's job.  Hands up anybody who spots 
> conflicting trends here already?  Who thinks the 128 bit requirement came 
> from marketing rather than the engineers?

Is that important? Who says Sun isn't going to put checksumming and
compression hardware into its machines, and tell ZFS and their hardware
drivers to use it? Keep ZFS tuned for new requirements as they emerge?

AFAIK, no-one has suggested ZFS yet for floppies (including LS120, ZIP
and that stuff - it was also a major hype, now with DVD-RAM, DVD+RW and
DVD-RW few people talk about LS120 or ZIP any more).

What if some breakthrough in storage gives us vastly larger (larger than
predicted harddisk storage density increases) storage densities in 10
years for the same price of a 200 or 300 GB disk drive now?

-- 
Matthias Andree
