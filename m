Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266332AbUAVTdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUAVTdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:33:50 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:16337 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266332AbUAVTds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:33:48 -0500
Date: Thu, 22 Jan 2004 11:33:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brian Ristuccia <bristucc@sw.starentnetworks.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 CONFIG_NUMA=y leads to random segfaults
Message-ID: <19890000.1074800028@[10.10.2.4]>
In-Reply-To: <20040121220800.GO5555@sw.starentnetworks.com>
References: <20040121220800.GO5555@sw.starentnetworks.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While building a kernel for a Dual Athlon MP 2800 system, I accidentally
> enabled CONFIG_NUMA, "Numa Memory Allocation Support". This option should
> have been a no-op on the system I was using it on, since on this motherboard
> all system memory is equally close to each of the two CPU's. Instead, it
> caused userspace processes to randomly segfault.
> 
> Booting a 2.6.0 rebuilt without CONFIG_NUMA made the problem go away.

Can you try 2.6.1 with Andi's latest patchset from here:
ftp://ftp.x86-64.org/pub/linux/v2.6/x86_64-2.6.1-2.bz2
There's been quite a few updates to AMD oustanding since before 2.6.0 
that Andi said were critical.

If it's still bust, could you fish around in /var/log/messages or consoles 
for any stack traces or anything you can see?

M.
