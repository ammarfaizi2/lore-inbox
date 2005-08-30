Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVH3M0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVH3M0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVH3M0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:26:19 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:56247 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S932108AbVH3M0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:26:19 -0400
Date: Tue, 30 Aug 2005 14:26:15 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Swap areas lose their signatures after reboot
Message-Id: <20050830142615.12910b57.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a machine with much RAM and 4 SCSI disks. We want to have 8 GB
of Swap space. So I partitioned the hard disks with one swap partition
of 2GB on every disk. But only the swap partition of the first disk can
be used after a reboot; the other three swap partitions lose their swap
signature.

When I call "swapon -a" manually, it says "Invalid argument" for these
three partitions. After executing "mkswap" on them, "swapon -a" works
fine. But I have to call "mkswap" after every reboot.

What happens with the swap signatures during reboot?

Regards
  Christoph
