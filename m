Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTEFSM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTEFSM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:12:56 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52235 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263969AbTEFSMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:12:50 -0400
Date: Tue, 6 May 2003 14:20:03 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: David van Hoose <davidvh@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] Zipdrive messages too much
In-Reply-To: <3EA6C732.2060504@cox.net>
Message-ID: <Pine.LNX.3.96.1030506141927.9452A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, David van Hoose wrote:

> I included ppa and scsi in my kernel since I have a parallel port 
> zipdrive. Problem I am having is that it keeps scanning the drive for 
> too much too often. Anytime I mount/unmount, plug/unplug USB and 
> firewire devices, or at random times, I get the following messages on my 
> console and in my messages file.

Was the zip drive recognized as removable?

> 
> Apr 23 11:41:35 aeon kernel: sda : READ CAPACITY failed.
> Apr 23 11:41:35 aeon kernel: sda : status = 1, message = 00, host = 0, 
> driver = 08
> Apr 23 11:41:35 aeon kernel: Current sd00:00: sns = 70  2
> Apr 23 11:41:35 aeon kernel: ASC=3a ASCQ= 0
> Apr 23 11:41:35 aeon kernel: Raw sense data:0x70 0x00 0x02 0x00 0x00 
> 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x3a 0x00 0x00 0x00 0x00 0x00 0xff 
> 0xfe 0x01 0x00 0x00 0x00 0x00
> Apr 23 11:41:35 aeon kernel: sda : block size assumed to be 512 bytes, 
> disk size 1GB.
> Apr 23 11:41:35 aeon kernel: sda: Write Protect is off
> Apr 23 11:41:35 aeon kernel:  sda: I/O error: dev 08:00, sector 0
> Apr 23 11:41:35 aeon kernel:  I/O error: dev 08:00, sector 0
> Apr 23 11:41:35 aeon kernel:  unable to read partition table
> Apr 23 11:41:35 aeon kernel: Device not ready.  Make sure there is a 
> disc in the drive.
> 
> This gets really annoying, but I like to use my zipdrive.
> Let me know if more information is needed.
> 
> Thanks,
> David
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

