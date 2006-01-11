Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWAKSed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWAKSed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWAKSed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:34:33 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:63469 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932501AbWAKSec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:34:32 -0500
Message-ID: <43C54FB9.9080906@ens-lyon.org>
Date: Wed, 11 Jan 2006 13:34:33 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org>
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/


Hi Andrew,

I am seeing the following message (which does not seem to cause any
problem):

pcmcia: Detected deprecated PCMCIA ioctl usage.
This interface will soon be removed from the kernel; please expect
breakage unless you upgrade to new tools.
pcmcia: see
http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x100-0x4ff: excluding 0x3f0-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
BUG: atomic counter underflow at:
 [<c01a0921>] kref_put+0x4d/0x68
 [<c01a0051>] kobject_put+0x16/0x19
 [<c01a0475>] kobject_release+0x0/0xa
 [<e0a40b20>] ds_ioctl+0x380/0x6e8 [pcmcia]
 [<c0153301>] do_ioctl+0x3d/0x4e
 [<c01534fc>] vfs_ioctl+0x1ea/0x1fb
 [<c0153538>] sys_ioctl+0x2b/0x47
 [<c0102a2d>] syscall_call+0x7/0xb

Any idea about what patch I could revert ?

Regards,
Brice

