Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSKMNw4>; Wed, 13 Nov 2002 08:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSKMNw4>; Wed, 13 Nov 2002 08:52:56 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:24292 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261847AbSKMNwy>; Wed, 13 Nov 2002 08:52:54 -0500
Message-Id: <4.3.2.7.2.20021113142640.00b15cc0@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 13 Nov 2002 14:59:36 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Linux 2.5.47-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PS2 mouse does not work.
Yes, "input devices", "PS2 mouse" and "legacy psaux" are configured :-)

Also :

Nov 13 14:19:55 roglinux kernel: Uninitialised timer!
Nov 13 14:19:55 roglinux kernel: This is just a warning.  Your computer is OK
Nov 13 14:19:55 roglinux kernel: function=0x00000000, data=0x0
Nov 13 14:19:55 roglinux kernel: Call Trace: 
[check_timer_failed+99/102]  [del_timer
+25/76]  [<e08c1012>]  [printk+265/316]  [<e08bacd4>]  [<e08b385d>] 
[<e08c1940>]  [
<e08b36f0>]  [<e08b8688>]  [load_elf_binary+2495/3086]  [<e08c1e00>] 
[<e08c1e28>]
[pci_device_probe+94/108]  [<e08c1980>]  [<e08c1e28>]  [bus_match+69/114] 
[<e08c1e2
8>]  [driver_attach+101/126]  [<e08c1e28>]  [<e08c1e28>]  [<e08c1e3c>] 
[bus_add_dri
ver+88/122]  [<e08c1e28>]  [<e08c1e28>]  [<e08c18e9>]  [<e08c1e4c>] 
[driver_registe
r+145/158]  [<e08c1e28>]  [pci_register_driver+68/84]  [<e08c1e28>] 
[<e08c16dd>]  [
<e08c1e00>]  [sys_init_module+1225/1548]  [<e08be060>]  [<e08c1dc4>] 
[<e08be060>]
[syscall_call+7/11]
Nov 13 14:19:55 roglinux kernel: Call Trace: 
[<c01217a3>]  [<c0121935>]  [<e08c1012>
]  [<c011a445>]  [<e08bacd4>]  [<e08b385d>]  [<e08c1940>]  [<e08b36f0>] 
[<e08b8688>
]  [<c0160039>]  [<e08c1e00>]  [<e08c1e28>]  [<c017d32a>]  [<e08c1980>] 
[<e08c1e28>
]  [<c01be9df>]  [<e08c1e28>]  [<c01beaf7>]  [<e08c1e28>]  [<e08c1e28>] 
[<e08c1e3c>
]  [<c01bed8e>]  [<e08c1e28>]  [<e08c1e28>]  [<e08c18e9>]  [<e08c1e4c>] 
[<c01bf30d>
]  [<e08c1e28>]  [<c017d442>]  [<e08c1e28>]  [<e08c16dd>]  [<e08c1e00>] 
[<c011b203>
]  [<e08be060>]  [<e08c1dc4>]  [<e08be060>]  [<c010aaef>]

Nov 13 14:19:55 roglinux kernel: Uninitialised timer!
Nov 13 14:19:55 roglinux kernel: This is just a warning.  Your computer is OK
Nov 13 14:19:55 roglinux kernel: function=0xe0917540, data=0xdeb9ef80
Nov 13 14:19:55 roglinux kernel: Call Trace: 
[check_timer_failed+99/102]  [<e0917540
 >]  [del_timer+25/76]  [<e09173c8>]  [<e09166f8>]  [<e0916965>] 
[<e0905ea4>]  [<e09
07450>]  [<e0905730>]  [<e0924e80>]  [<e0906dfd>]  [<e0906ec3>] 
[<e0908408>]  [<e09
21855>]  [<e0902e84>]  [<e0920dfb>]  [sys_init_module+1225/1548] 
[<e0902060>]  [<e0
902060>]  [syscall_call+7/11]
Nov 13 14:19:55 roglinux kernel: Call Trace: 
[<c01217a3>]  [<e0917540>]  [<c0121935>
]  [<e09173c8>]  [<e09166f8>]  [<e0916965>]  [<e0905ea4>]  [<e0907450>] 
[<e0905730>
]  [<e0924e80>]  [<e0906dfd>]  [<e0906ec3>]  [<e0908408>]  [<e0921855>] 
[<e0902e84>
]  [<e0920dfb>]  [<c011b203>]  [<e0902060>]  [<e0902060>]  [<c010aaef>]

