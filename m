Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWIPIxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWIPIxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWIPIxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:53:25 -0400
Received: from charon.hkfree.org ([212.71.131.229]:59346 "EHLO
	charon.hkfree.org") by vger.kernel.org with ESMTP id S964818AbWIPIxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:53:24 -0400
From: Martin Kourim <martink@hkfree.org>
To: linux-kernel@vger.kernel.org
Subject: sluggish system with 2.6.17 and dm-crypt
Date: Sat, 16 Sep 2006 10:53:19 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609161053.20317.martink@hkfree.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got this problem with linux 2.6.17 and dm-crypt.

I've got 320GB PATA hdd with one partition with dm-crypt and ext3. I've set it 
up with cryptsetup.
When I copy some data to this encrypted partition, system is very sluggish. It  
freezes for about half a second every about 10-15 seconds.
This problem appears only when copying data to that encrypted partition. There 
is no problem copying data to other unencrypted partitions or from encrypted 
partition.

I've thought that maybe it is problem with just Debian kernels (tried 
linux-image-2.6.17-2-vserver-k7_2.6.17-8 and 
linux-image-2.6.17-2-k7_2.6.17-8), but I've got the same problem with vanilla 
2.6.17.13.
But... there is no problem with linux v2.6.16 (compiled from Debian sources).

I've tried different io schedulers too (cfq, anticipatory and deadline) with 
no difference.

This system is AthlonXP 2600+, 1gb ram, 2x SATA hdd and 2x PATA hdd, mb asus 
A7N8X-E deluxe.

What other information should I provide?

Thanks,
Martin Kourim

(please CC me)
