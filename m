Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281557AbRKMJRU>; Tue, 13 Nov 2001 04:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281558AbRKMJRB>; Tue, 13 Nov 2001 04:17:01 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:20392 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281557AbRKMJQz>; Tue, 13 Nov 2001 04:16:55 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200111130916.fAD9Gvi32288@devserv.devel.redhat.com>
Subject: Re: [PATCH] Ramdisk ioctl bug fix, kernel 2.4.14
To: mhteas@btech.com (Malcolm H. Teas)
Date: Tue, 13 Nov 2001 04:16:56 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (linux-kernel), alan@redhat.com
In-Reply-To: <3BF087DA.2010908@btech.com> from "Malcolm H. Teas" at Nov 12, 2001 08:39:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below makes the ramdisk return the actual size that is currently 
> allocated instead of returning the max size we can possibly allocate.  Affects 
> system calls ioctl(filedes, BLKGETSIZE) and ioctl(filedes, BLKGETSIZE64) for 
> ramdisk devices.

That seems to be the opposite of what its always done, and also of what
disk devices do.
