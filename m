Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbRA2N07>; Mon, 29 Jan 2001 08:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRA2N0t>; Mon, 29 Jan 2001 08:26:49 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:34319 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130132AbRA2N0n>; Mon, 29 Jan 2001 08:26:43 -0500
Date: Mon, 29 Jan 2001 13:26:40 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <Tony.Young@ir.com>
cc: <chris@scary.beasts.org>, <slug@slug.org.au>, <csa@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Linux Disk Performance/File IO per process
In-Reply-To: <C0D2F5944500D411AD8A00104B31930E10809C@ir_nt_server2>
Message-ID: <Pine.LNX.4.30.0101291209290.3063-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Jan 2001 Tony.Young@ir.com wrote:

> Thanks to both Jens and Chris - this provides the information I need to
> obtain our busy rate
> It's unfortunate that the kernel needs to be patched to provide this
> information - hopefully it will become part of the kernel soon.
>
> I had a response saying that this shouldn't become part of the kernel due to
> the performance cost that obtaining such data will involve. I agree that a
> cost is involved here, however I think it's up to the user to decide which
> cost is more expensive to them - getting the data, or not being able to see
> how busy their disks are. My feeling here is that this support could be user
> configurable at run time - eg 'cat 1 > /proc/getdiskperf'.

Hi,

I disagree with this runtime variable. It is unnecessary complexity.
Maintaining a few counts is total noise compared with the time I/O takes.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
