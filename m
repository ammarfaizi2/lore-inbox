Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265940AbSKBLtp>; Sat, 2 Nov 2002 06:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265941AbSKBLtp>; Sat, 2 Nov 2002 06:49:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:51117 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265940AbSKBLto>;
	Sat, 2 Nov 2002 06:49:44 -0500
Message-ID: <3DC3BD57.DDFCBB9C@digeo.com>
Date: Sat, 02 Nov 2002 03:56:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45-bk1: kernel BUG at drivers/block/ll_rw_blk.c:1949!
References: <3DC3B5AE.E91AF724@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 11:56:07.0504 (UTC) FILETIME=[D4030D00:01C28266]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> I got this during boot. Kernel 2.5.45-bk1,
> compiled with gcc 2.95.4, SMP+preempt
> The machine has 2 scsi disks and a
> tekram controller.
> 
> Helge Hafting
> 
> kernel BUG at drivers/block/ll_rw_blk.c:1949!
> invalid operand: 0000
> CPU:    1
> EIP:    0060:[<c0236c86>]    Not tainted
> EFLAGS: 00010246
> EIP is at submit_bio+0x16/0xa8

RAID0 does that.  Are you using raid?
