Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVJGCIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVJGCIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 22:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVJGCIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 22:08:11 -0400
Received: from xenotime.net ([66.160.160.81]:62849 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751271AbVJGCIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 22:08:10 -0400
Date: Thu, 6 Oct 2005 19:08:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: devesh sharma <devesh28@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues in Booting kernel 2.6.13
Message-Id: <20051006190806.388289ff.rdunlap@xenotime.net>
In-Reply-To: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com>
References: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005 10:46:37 +0530 devesh sharma wrote:

> Hi all,
> I have compiled 2.6.13 kernel on a opteron machine with 1 GB physical
> memory, Whole compilation gose well but at the last step
> make install I am getting a warning
> WARNING: No module mptbase found for kernel 2.6.13, continuing anyway
> WARNING: No module mptscsih found for kernel 2.6.13, continuing anyway

If you need mpt drivers, there were some changes in the
FUSION MPT driver options that may be causing them not to be
built for you as you were expecting.

> now when I boot my kernel, panic is received
> Booting the kernel.
> Red Hat nash version 4.1.18 starting
> mkrootdev: lable / not found
> mount: error 2 mounting ext3
> mount: error 2 mounting none
> switchroot: mount failed : 22
> umount : /initrd/dev failed : 22
> kernel panic - not syncing : Attempted to kill init
> 
> What could be the problem?
> I have RHEL 4 base release already installed on which I have compiled
> this image.


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
