Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUFJX2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUFJX2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUFJX2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:28:04 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:13810 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262902AbUFJX2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:28:02 -0400
Date: Thu, 10 Jun 2004 19:22:28 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) on Linux status report (2.6.x mainstream plan
 for AHCI and iswraid??)
In-Reply-To: <Pine.GSO.4.33.0406101452220.14297-100000@sweetums.bluetronic.net>
Message-ID: <Pine.GSO.4.33.0406101919440.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2004, Ricky Beam wrote:
>...  For example:
>  mdadm --build /dev/md/d0 --chunk=16 --level=0 --raid-devices=4 /dev/sd[abcd]
>or a dm-table:
>  0 1250327228 striped 4 32 /dev/sda 0 /dev/sdb 0 /dev/sdc 0 /dev/sdd 0
>works for me (4x160G SATA drives on a SI3114 in raid0 mode.)  The same
>md setup can be done via the kernel cmdline to boot into the array.

And that cmdline is... (wait for it, *pause*, wait for it)
	md=d0,0,2,0,/dev/sda,/dev/sdb,/dev/sdc,/dev/sdd

--Ricky


