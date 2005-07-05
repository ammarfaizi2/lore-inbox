Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVGEJZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVGEJZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 05:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVGEJZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 05:25:24 -0400
Received: from [217.222.53.238] ([217.222.53.238]:44185 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S261774AbVGEJZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 05:25:05 -0400
Message-ID: <42CA51E3.8030803@gts.it>
Date: Tue, 05 Jul 2005 11:24:51 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: Kernel unable to read partition table on USB Memory Key
References: <40BC5D4C2DD333449FBDE8AE961E0C334F9364@psexc03.nbnz.co.nz>
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C334F9364@psexc03.nbnz.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberts-Thomson, James wrote:
> Hi,
> 
> I'm trying to diagnose an issue with a USB "Memory Key" (128Mb Flash drive)
> on my workstation (i386 Linux 2.6.12 kernel, using udev 058).
> 
> When connecting the key, the kernel fails to read the partition table, and
> therefore the block device /dev/sda1 isn't created, so I can't mount the
> volume.  Calling "fdisk" manually, however, makes it all work.
> 
> 
> Bus 001 Device 004: ID 0ea0:2168 Ours Technology, Inc. Transcend JetFlash
> 2.0

Hi all,

Just a "vote" for this: same USB key, same symptoms, same inability to 
use the key: I can create the fs and use it, but once unmounted it won't 
be mounted anymore.

Bye

-- 
Stefano RIVOIR

