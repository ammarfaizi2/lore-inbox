Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTJETbR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTJETbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:31:17 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:39048 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S263788AbTJETbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:31:15 -0400
Message-ID: <3F80717E.6060300@comcast.net>
Date: Sun, 05 Oct 2003 12:31:10 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030927
X-Accept-Language: en-us
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6-mm4
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem booting 2.6.0-test6-mm(2-4) when using an initrd.
Seems that the initrd never gets loaded, and the root filesystem never
gets mounted as a result. Reverting RD0-initrd-B6.patch allows initrd to
work again, and my machine to boot. I'm using a standard non-initramfs
initrd and a devfs enabled SMP kernel. I don't see any of the printk's
regarding ramdisk/initrd in any boot messages prior to panic. Let me
know if you need anything else. Thanks,

-Walt

mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Kernel panic: VFS: Unable to mount root fs on hda3


