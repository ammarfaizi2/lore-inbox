Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUHISZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUHISZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUHISZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:25:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24480 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266831AbUHISXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:23:04 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc3-mm2
Date: Mon, 9 Aug 2004 11:22:48 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040808152936.1ce2eab8.akpm@osdl.org>
In-Reply-To: <20040808152936.1ce2eab8.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091122.48492.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 8, 2004 3:29 pm, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6
>.8-rc3-mm2/

Hangs on boot for me, and doesn't appear related to the dont-pass-mem_map-* 
patches (I reverted them and got the same behavior, besides I think the 
kernel is past paging_init at this point).  Trying to track it down.

Jesse

SGI SAL version 3.40
Virtual mem_map starts at 0xa0007fffce938000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=scsi0:\EFI\sgi\vmlinuz.jb root=/dev/sda3 
console=ttySG0 console=ttyS0 ro
PID hash table entries: 4096 (order 12: 65536 bytes)
CPU 0: base freq=200.000MHz, ITC ratio=10/2, ITC freq=1000.000MHz+/--1ppm
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
Memory: 5937856k/6004928k available (7074k code, 79072k reserved, 3376k data, 
352k init)
McKinley Errata 9 workaround not needed; disabling it
Calibrating delay loop... 1481.36 BogoMIPS (lpj=722944)
Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
Boot processor id 0x0/0x0
task migration cache decay timeout: 10 msecs.
** hang, then machine check **
