Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSGSIUT>; Fri, 19 Jul 2002 04:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318469AbSGSIUT>; Fri, 19 Jul 2002 04:20:19 -0400
Received: from [196.26.86.1] ([196.26.86.1]:40852 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318468AbSGSIUS>; Fri, 19 Jul 2002 04:20:18 -0400
Date: Fri, 19 Jul 2002 10:41:07 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Doug Ledford <dledford@redhat.com>
Cc: Dale Amon <amon@vnl.com>, <linux-kernel@vger.kernel.org>,
       Frank Davis <fdavis@si.rr.com>
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
In-Reply-To: <20020718210340.A28235@redhat.com>
Message-ID: <Pine.LNX.4.44.0207190857570.29194-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Doug Ledford wrote:

> Attached you will find a patch that compiles cleanly, but is totally 
> untested.  Testing would be appreciated.  I suspect FlashPoint controllers 
> *might* have a problem, but MultiMaster (or whatever they are called) 
> should work properly.  WARNING: This could eat a filesystem, it's totally 
> untested DMA mapping code and I have *no* BusLogic controllers to do any 
> sort of verifications with.  The brave at heart are needed to let me know 
> if this thing works ;-)

Boots and is in multiuser right now =) I'll thrash it about right now and 
see if anything falls over. However i commented out scsi_mark_host_reset, 
but it doesn't seem to be defined anywhere.

Thanks,
	Zwane

scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host 
Adapter
scsi0:   Firmware Version: 5.07B, I/O Address: 0x1080, IRQ Channel: 
11/Level
scsi0:   PCI Bus: 0, Device: 16, Address: 0xFD000000, Host Adapter SCSI 
ID: 7
scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
scsi0:   Synchronous Negotiation: Ultra, Wide Negotiation: Enabled
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
scsi0: *** BusLogic BT-958 Initialized Successfully ***
scsi0 : BusLogic BT-958

-- 
function.linuxpower.ca



