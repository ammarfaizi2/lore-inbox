Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbTEYUcT (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTEYUcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:32:19 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4341 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263748AbTEYUcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:32:18 -0400
Date: Sun, 25 May 2003 22:45:00 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Willy Tarreau <willy@w.ods.org>,
   Marcelo Tosatti <marcelo@conectiva.com.br>,
   lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
In-Reply-To: <20030525203709.GA23651@matchmail.com>
Message-ID: <Pine.SOL.4.30.0305252242430.10573-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Everything is okay, older drives don't understand some commands.
I will fix it, but now its low on my TODO list.

On Sun, 25 May 2003, Mike Fedyk wrote:

> On Sun, May 25, 2003 at 07:00:46PM +0200, Willy Tarreau wrote:
> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
>
> Can you revert back to your previous kernel and run badblocks read-only on
> it a few times.  Your drive may be going bad.

