Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUCSLjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 06:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUCSLjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 06:39:10 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:38731 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S262756AbUCSLjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 06:39:07 -0500
Date: Fri, 19 Mar 2004 11:39:04 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc1-mm2 very slow
In-Reply-To: <20040319101451.GM22234@suse.de>
Message-Id: <Pine.LNX.4.58.0403191136450.18369@praktifix.dwd.de>
References: <Pine.LNX.4.58.0403190956560.18369@praktifix.dwd.de>
 <20040319101451.GM22234@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Jens Axboe wrote:

> On Fri, Mar 19 2004, Holger Kiehl wrote:
> > Hello
> > 
> > I am testing 2.6.5-rc1-mm2 and find it very slow when I do a bonnie
> > test, also the system itself feels very sluggish. Looking at dmesg
> > I get the following:
> > 
> >    Badness in elv_remove_request at drivers/block/elevator.c:249
> >    Call Trace:
> >     [<c028b28f>] elv_remove_request+0x8d/0x8f
> >     [<c02b6a4e>] scsi_request_fn+0x289/0x333
> >     [<c028b174>] elv_next_request+0x3d/0xcb
> >     [<c028c8da>] generic_unplug_device+0x43/0x45
> 
> Does it still complain with this patch?
> 
No, this also fixes the slowness. Performance is back to normal.

That was the quickest patch I have ever received :)

Many thanks!

Holger
