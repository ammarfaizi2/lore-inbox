Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUBBMIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUBBMIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:08:18 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:20609 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265442AbUBBMIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:08:16 -0500
Date: Mon, 2 Feb 2004 12:17:19 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402021217.i12CHJdP001539@81-2-122-30.bradfords.org.uk>
To: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040202120120.GC570@DervishD>
References: <20040202120120.GC570@DervishD>
Subject: Re: Problem with IDE taskfile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: status=3D0x51 { Dri=
> veReady SeekComplete Error }
> <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: error=3D0x04 { Driv=
> eStatusError }
> <30>Feb  2 12:18:41 kernel: hdb: 8420832 sectors (4311 MB) w/512KiB Cac=
> he, CHS=3D524/255/63, UDMA(33)
> 
>     The problem is that message from function 'task_no_data_intr'.
> What can be the problem?

The drive doesn't understand the command it was sent.

> Should I worry about it?

No.

> Is the drive
> damaged?

No.

>     I've tested with another hard disk from the same time (the same
> model but 3GB) and the same messages appear. They doesn't appear with
> a disk of 10GB, same brand, a bit newer than the other two. And
> obviously, it doesn't happen with the 40GB disk which is my hda...

Old drives don't support all of the commands that new drives do.  It's
a diagnostic message.

John.
