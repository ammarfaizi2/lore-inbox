Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSJXWzl>; Thu, 24 Oct 2002 18:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSJXWzl>; Thu, 24 Oct 2002 18:55:41 -0400
Received: from bozo.vmware.com ([65.113.40.131]:48909 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S265705AbSJXWzj>; Thu, 24 Oct 2002 18:55:39 -0400
Date: Thu, 24 Oct 2002 16:02:29 -0700
From: chrisl@vmware.com
To: linux-kernel@vger.kernel.org
Subject: How to get number of physical CPU in linux from user space?
Message-ID: <20021024230229.GA1841@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that /proc/cpuinfo will return the number of logical CPU.
If the machine has Intel Hyper-Thread enabled, that number is bigger
than physical CPU number. Usually twice as big.

My question is, what is the reliable way for user space program
to detect the number of physical CPU in the current machine?

If in it is in the kernel, I can read from cpu_sibling_map[]
or phys_cpu_id[]. But it seems not easy read that from
user space.

Of course I can do "gdb /proc/kcore" to get them. But is there
any better way?

Thanks in advance.

Chris



