Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQKTOjZ>; Mon, 20 Nov 2000 09:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131797AbQKTOjP>; Mon, 20 Nov 2000 09:39:15 -0500
Received: from 213-123-77-214.btconnect.com ([213.123.77.214]:26372 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129532AbQKTOjK>;
	Mon, 20 Nov 2000 09:39:10 -0500
Date: Mon, 20 Nov 2000 14:10:37 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Charles Turner, Ph.D." <cturner@quark.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com>
Message-ID: <Pine.LNX.4.21.0011201402260.1575-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Charles Turner, Ph.D. wrote:
> 	I certainly don't know what to purchase for my
> 	next attempt at a "shrink-wrap" installation.

Try Red Hat 7.0 -- it is certainly better. True, no distribution is
perfect but over the years I've developed my own CD image upgrade.iso
which goes directly after installing latest Red Hat distribution. It is
full of things like BRS, dict(1), 'alias md="mkdir -p"' or "set
editing-mode vi" which should be installed by default but for some reason
aren't. upgrade.iso is about 120M which means there is only 120M of bits
that separate "plain red hat" from "perfect Linux workstation" (assuming
my configuration is perfect :) Red Hat 7.0 installed just fine on a range
of my home machines from 486/66MHz/16M RAM to PIII laptop to 2way PIII
desktop to 4way Xeon server -- some with SCSI, some without -- no glitches
whatsoever. 

So, instead of blaming some old obsolete versions of Red Hat, try the
latest, especially when recommending to a friend.

The only obvious bug present even in the latest Red Hat 7.0 (which I keep
forgetting to report to them) is that it won't boot if you install on a
disk with lots of foreign partitions (I have UnixWare 7 and FreeBSD 4.x
there) because the installation kernel doesn't support them and the final
kernel does which creates a mismatch in the partition numbering.

The above bug is not critical as Andries Brouwer has long ago fixed this
bug in the 2.4 kernel (i.e. made DOS physical partitions enumerated first
so no foreign partitions can mix anything up) so the workaround is -- boot
your system somehow (be a man, find _some_ way of booting your system even
if there is no way ;) and then install 2.4 kernel and from then on
everything will be okay.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
