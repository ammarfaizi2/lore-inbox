Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQKTSxo>; Mon, 20 Nov 2000 13:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129768AbQKTSxX>; Mon, 20 Nov 2000 13:53:23 -0500
Received: from penguin.engin.umich.edu ([141.213.33.36]:20754 "EHLO
	penguin.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S129205AbQKTSxQ>; Mon, 20 Nov 2000 13:53:16 -0500
Date: Mon, 20 Nov 2000 13:23:11 -0500 (EST)
From: Chris Wing <wingc@engin.umich.edu>
To: Andreas Jaeger <aj@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: struct acct uses 16bit uids :-(
Message-ID: <Pine.LNX.4.21.0011201317360.4429-100000@penguin.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas:

My changes for process accounting were not accepted along with the rest of
the 32-bit UID patches. The current state of things as I understand it is
that SGI is working on some "enhanced" accounting support for Linux, which
may end up replacing the current process accounting. (stuff like job
accounting and more resource usage statistics)

Of course, if Linux 2.4 were to include 32-bit UID fields in the current
accounting structure like this patch:

	http://www.engin.umich.edu/caen/systems/Linux/code/misc/2.3/20000110/linux-acct.patch

we here at U-M would have no objection :)


Andreas Jaeger (aj@suse.de) wrote:

> Hi,
> 
> is anybody maintaining the BSD process accounting? It's currently
> broken since it still uses 16 bit uids :-(

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
