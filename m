Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbUBFLQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUBFLQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:16:40 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60165
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265423AbUBFLQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:16:31 -0500
Date: Fri, 6 Feb 2004 03:11:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Jones <davej@redhat.com>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with IDE taskfile
In-Reply-To: <20040202202522.GA9503@redhat.com>
Message-ID: <Pine.LNX.4.10.10402060310450.11954-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It means the drive aborted the unsupported command set.

Andre Hedrick
LAD Storage Consulting Group

On Mon, 2 Feb 2004, Dave Jones wrote:

> On Mon, Feb 02, 2004 at 01:01:20PM +0100, DervishD wrote:
> 
>  > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
>  > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: error=0x04 { DriveStatusError }
>  > <30>Feb  2 12:18:41 kernel: hdb: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=524/255/63, UDMA(33)
>  > 
>  >     The problem is that message from function 'task_no_data_intr'.
>  > What can be the problem? Should I worry about it? Is the drive
>  > damaged?
> 
> 51/04 is the drive saying "I don't understand what you asked me to do".
> Ie, a command that was added to a later revision of the ATA standard
> than your drive conforms to.  Judging by the size of the drive,
> I'd guess it's quite old 8-)
> 
> 		Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

