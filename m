Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbTDLH4I (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTDLH4I (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:56:08 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54794
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263192AbTDLH4F (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 03:56:05 -0400
Date: Sat, 12 Apr 2003 01:06:33 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Troy Rollo <linux@troy.rollo.name>
cc: linux-kernel@vger.kernel.org
Subject: Re: DMA Timeouts with 3112 SATA Controller (status == 0x21)
In-Reply-To: <4.3.1.2.20030412164450.02817b10@mail>
Message-ID: <Pine.LNX.4.10.10304120039570.23693-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gurr!!!!!!!

These drives were not to make it to market in the commom purchase
marketspace!

This is not a fun one to fix!

This is all I can say for now :-(

On Sat, 12 Apr 2003, Troy Rollo wrote:

> "Me too" - when I enable DMA it's not long before the system stops 
> responding altogether. Without DMA, I get a data read rate of about 800KBps.
> 
> But also, I have two identical drives attached - hda and hde (both 
> ST380023AS). Even if I don't turn on DMA, if I am using both fairly 
> intensively at the same time (at least that's the only thing I can identify 
> as an apparent common difference), one will (on random occasions) start 
> returning errors for every access. If this happens to be the drive that the 
> operating system is installed on, the result is somewhat fatal. If it's the 
> other drive I can continue, but any attempt to access it fails. There are 
> some syslog entries that appear to relate to this:
> 
> Apr 11 07:42:49 milat kernel: hde: status timeout: status=0xd0 { Busy }
> Apr 11 07:42:49 milat kernel:
> Apr 11 07:42:49 milat kernel: ide2: reset phy, status=0x00000113, siimage_reset
> Apr 11 07:42:49 milat kernel: hde: no DRQ after issuing WRITE
> Apr 11 07:43:19 milat kernel: ide2: reset timed-out, status=0xd8
> Apr 11 07:43:20 milat kernel: hde: status timeout: status=0xd8 { Busy }
> Apr 11 07:43:20 milat kernel:
> Apr 11 07:43:20 milat kernel: ide2: reset phy, status=0x00000113, siimage_reset
> Apr 11 07:43:20 milat kernel: hde: drive not ready for command
> Apr 11 07:43:51 milat kernel: t: I/O error, dev 21:02 (hde), sector 6183724
> Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
> sector 6183726
> Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
> sector 6183728
> Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
> sector 6183730
> Apr 11 07:43:51 milat kernel: end_request: I/O error, dev 21:02 (hde), 
> sector 6183732
> ...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

