Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbSJHPBV>; Tue, 8 Oct 2002 11:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSJHPBV>; Tue, 8 Oct 2002 11:01:21 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:27408 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261314AbSJHPBU>; Tue, 8 Oct 2002 11:01:20 -0400
Date: Tue, 8 Oct 2002 17:02:08 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops when rebooting
Message-ID: <20021008150208.GA4319@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <3DA2EF5D.4080504@ndmnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA2EF5D.4080504@ndmnet.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent@ndmnet.com>
Date: Tue, Oct 08, 2002 at 06:44:45AM -0800
> Just compiled 2.5.41, everything seems to work fine except it oopses 
> reliably when rebooting. It's a tyan tiger mpx with a single cpu. Kernel 
> was configured for smp, preemptible, and acpi. I can send my .config if 
> it'll help
> 
> Oops is in driverfs_remove_file + 0x46/0x60
> Process reboot
> Call trace:
> device_remove_file
> driverfs_remove_partitions
> del_gendisk
> idedisk_cleanup
> ide_notify_reboot
> notifier_call_chain
> sys_reboot
> __get_page_state
> sync_inodes_sb
> backround_writeout
> sync_inodes
> syscall_call
> 
Me too - Abit VP6, via-694 smp, dual P3/700 cpu's. Not always, but it
happens sometimes.

Kind regards,
Jurriaan
-- 
#ifdef __LITERAL_BIBLICAL_FUNDAMENTALISM
#define PI 3.0                          /* 1 Kings 7:23 */
#endif
	Peter Seebach - C infrequently asked questions (c) 1995,1996,1997
GNU/Linux 2.5.41 SMP/ReiserFS 2x1380 bogomips load av: 1.24 0.62 0.24
