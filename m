Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBDRkD>; Sun, 4 Feb 2001 12:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbRBDRjx>; Sun, 4 Feb 2001 12:39:53 -0500
Received: from dnvrdslgw14poolB96.dnvr.uswest.net ([63.228.85.96]:28788 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S129051AbRBDRjk>;
	Sun, 4 Feb 2001 12:39:40 -0500
Date: Sun, 4 Feb 2001 10:39:38 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: <linux-kernel@vger.kernel.org>
cc: <tmh@magenta-logic.com>
Subject: Re: ACPI broken in 2.4.1
In-Reply-To: <3A7D748C.6080701@magenta-logic.com>
Message-ID: <Pine.LNX.4.31.0102041029180.5795-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I waited out the boot so I could login and experiment, but it was
painfully slow.

Compiling with just APM in and no ACPI, results in a correctly-running
machine with rh7 gcc-2.96-69.

I got lucky this time that with APM worked, else I'd be stuck with slowly
fscking, since this last boot I had to fsck two of my partitions (maximum
mount count exceeded...)  I don't even want to know how long it'd take to
fsck my almost 60GB worth of disks on this machine...  If that were the
case, I guess I'd be better off fscking with 2.4.0 and then coming back
in... ouch.

-bc

On Sun, 4 Feb 2001, Tony Hoyle wrote:

> Date: Sun, 04 Feb 2001 15:26:04 +0000
> From: Tony Hoyle <tmh@magenta-logic.com>
> To: linux-kernel@vger.kernel.org
> Subject: ACPI broken in 2.4.1
>
> In my wifes' machine 2.4.1 (both vanilla and -ac2) enabling ACPI causes
> the machine to run so slowly it's unusable.  On my machine it's OK.
> 2.4.0 worked fine, so something has changed between 2.4.0 and 2.4.1 that
> broke it.  I couldn't find anything in dmesg that looked any different,
> though.  However since that machine has never successfully booted with
> ACPI on the kern.log hasn't been written so it's unlikely I'd find anything.
>
> Tony


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
