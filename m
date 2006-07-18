Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWGRSSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWGRSSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWGRSSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:18:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:33220 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932338AbWGRSSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:18:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NGqjzKQB49aMuAXznO00z0bXjPgbIOS73N/SPGd4YSEpt2ks07soB7Pqj/yqR0b0Jv2ZGa57QVmffFSb0JBzXZpatD3medzUHcFko2wG7VS91ZnCRtqVaBETxpCTWHfYRqCPFBzshyY9y8cL/ldXJyt1yZw8WVsDKjcOO4S7Bms=
Message-ID: <7f45d9390607181118t5d4a0d35heca85fe6e03fc30e@mail.gmail.com>
Date: Tue, 18 Jul 2006 12:18:35 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: "uClinux development list" <uClinux-dev@uclinux.org>,
       LKML <linux-kernel@vger.kernel.org>, "Nicolas Pitre" <nico@cam.org>
Subject: IP-Config: No network devices available.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've compiled the smc91x driver into my kernel (CONFIG_SMC91X=y), but
the boot process complains `IP-Config: No network devices available.'
I tried using the netdev kernel parameter to start the smc91x driver
(netdev=1,0x300,eth0 and ether=1,0x300,eth0), but I don't see any
output on the console from the smc91x driver. The driver doesn't
appear to be starting. How do I start the smc91x driver? I'm compiling
linux.2.6.14.7-hsc0 for ARM nommu (Atmel AT91).

Thanks,
Shaun

Linux version 2.6.14.7-hsc0-sdj0 (sjackman@jinx.pathway.internal) (gcc
version 4.2.0 20060629 (experimental)) #28 Tue Jul 18 12:07:39 MDT
2006
CPU: Atmel-AT91M40xxx [14080044]
Machine: ATMEL EB01
Memory management: Non-Paged(unused/noMMU)
CPU0: D no cache
Built 1 zonelists
Kernel command line: root=/dev/ram initrd=0x15a0000,64K keepinitrd
ether=1,0x300,eth0 ip=dhcp
PID hash table entries: 16 (order: 4, 256 bytes)
Dentry cache hash table entries: 256 (order: -2, 1024 bytes)
Inode-cache hash table entries: 128 (order: -3, 512 bytes)
Memory: 1MB = 1MB total
Memory: 912KB available (858K code, 79K data, 4K init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
DCC: JTAG1 Serial emulation driver driver $Revision: 1.1 $
ttyJ0 at MMIO 0x12345678 (irq = 0) is a DCC
io scheduler noop registered
NET: Registered protocol family 2
IP route cache hash table entries: 16 (order: -6, 64 bytes)
TCP established hash table entries: 64 (order: -4, 256 bytes)
TCP bind hash table entries: 64 (order: -4, 256 bytes)
TCP: Hash tables configured (established 64 bind 64)
TCP reno registered
TCP bic registered
NET: Registered protocol family 17
IP-Config: No network devices available.
Freeing init memory: 4K
BINFMT_FLAT: Loading file: /init
Mapping is 1038000, Entry point is 44, data_start is 80
Load /init: TEXT=1038040-1038080 DATA=1038084-10380c4 BSS=10380c4-10380d4
Hello, world!
Kernel panic - not syncing: Attempted to kill init!
