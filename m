Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291624AbSCDFQw>; Mon, 4 Mar 2002 00:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSCDFQn>; Mon, 4 Mar 2002 00:16:43 -0500
Received: from smtp.mailbox.co.uk ([195.82.125.32]:27835 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S291624AbSCDFQ1>; Mon, 4 Mar 2002 00:16:27 -0500
Date: Mon, 4 Mar 2002 05:14:43 +0000 (GMT)
From: Jon Masters <jonathan@jonmasters.org>
To: linux-kernel@vger.kernel.org
cc: jonathan@jonmasters.org
Subject: Loopback (2.4.18)
Message-ID: <Pine.LNX.4.10.10203040448130.2990-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use "multiCD" to backup around 3 lots of 25GB of data in to
handy CD sized images. The software is a perl script which uses a loopback
mounted file on which a standard ext2 filesystem with data is written,
etc. I'm sure everyone gets the idea. These then get scp'd/burned.

Anyway, after about the 10th image the box starts having issues, which
ultimately result in a hard reset and resync of a bunch of software RAID5
arrays residing on it. The symptoms are as if it is not possible to fork a
new process, though it is responsive to icmp, etc. I was advised
previously to try upgrading to 2.4.18 in response to a previous (presumed
to be vm issue) and so I did that just now with no luck. Generally the box
is running fine on a daily basis, handles very high load and memtest86.

Before anything else, can someone just let me know what the current status
of loopback in 2.4 is - I know it was very broken originally but was then
okish just prior to 2.4.17 at which point I am purely guessing it's not
ok once more - perhaps I should keep different kernels for different tasks
(yes that's meant to be a joke - it's probably only amusing to me...) :-)

Kernel 2.4.18 (stock Linus kernel from kernel.org), AMD 900MHz Duron CPU,
1.5GB SDRAM (highmem enabled), various RAID5 /dev/md0-/dev/md3, reiserfs,
NFS/Samba/Automounter/NIS/etc. etc. Just a fileserver really.

I reckon I'm going to end up having to copy the data to another machine
running 2.2 and run the backup from there - but first time for sleep...

Thanks for any replies,

Jon.

