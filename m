Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUARAMV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 19:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbUARAMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 19:12:21 -0500
Received: from smtp09.auna.com ([62.81.186.19]:44730 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262328AbUARAMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 19:12:19 -0500
Date: Sun, 18 Jan 2004 01:12:17 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.1-mm4
Message-ID: <20040118001217.GE3125@werewolf.able.es>
References: <20040115225948.6b994a48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org> (from akpm@osdl.org on Fri, Jan 16, 2004 at 07:59:48 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.16, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/
> 
> 

Net driver problem:

werewolf:/etc# modprobe --verbose 3c59x
insmod /lib/modules/2.6.1-jam4/kernel/drivers/net/3c59x.ko 
FATAL: Error inserting 3c59x (/lib/modules/2.6.1-jam4/kernel/drivers/net/3c59x.ko): Invalid argument

/var/messages:
Jan 18 01:03:00 werewolf kernel: 3c59x: falsely claims to have parameter rx_copybreak

Hardware:

00:12.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
        Subsystem: 3Com Corporation: Unknown device 1000
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at ec00 [size=128]
        Memory at febfef80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at feba0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

(if you answer from netdev, plz CC: me, I'm not subscribed. thanks)

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-jam4 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
