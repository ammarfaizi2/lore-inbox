Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268501AbTCFW6Z>; Thu, 6 Mar 2003 17:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268496AbTCFW6Y>; Thu, 6 Mar 2003 17:58:24 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:20698 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S268501AbTCFW5X>; Thu, 6 Mar 2003 17:57:23 -0500
Subject: Re: Linux 2.5.64-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, aeb@cwi.nl
In-Reply-To: <20030306225823.GA2764@win.tue.nl>
References: <200303061915.h26JFAP06033@devserv.devel.redhat.com>
	<1046985881.4992.99.camel@spc9.esa.lanl.gov>
	<1046991076.17715.129.camel@irongate.swansea.linux.org.uk> 
	<20030306225823.GA2764@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Mar 2003 16:03:39 -0700
Message-Id: <1046991819.4872.109.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 15:58, Andries Brouwer wrote:
> On Thu, Mar 06, 2003 at 10:51:16PM +0000, Alan Cox wrote:
> > On Thu, 2003-03-06 at 21:24, Steven Cole wrote:
> > > I backed out the same partitions stuff as before, and 2.5.64-ac1 boots
> > > fine.  This is the resulting diff.
> > 
> > Backing it out isnt an option in the end, it has to get fixed 8(
> 
> Usually I try to follow partition and geometry stuff, but this
> is a discussion I missed.  What is wrong?
> 
> Andries

Here are the symptoms if that will help.  
Copied by hand when it died on boot.

Call Trace:

ide_xlate_1024+0xf5
read_dev_sector+0x69
handle_ide_mess+0x179
msdos_partition+0x3c
call_console_drivers+0xeb
printk+0x17d
check_partition+0xac
register_disk+0xd0
blk_register_region+0x24
add_disk+0x35
exact_match+0x0
exact_lock+0x0
sd_attach+0x291
scsi_register_device+0x94
init+0x62
init+0x0
kernel_thread_helper+0x5

Steven

