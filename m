Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272393AbTHEDJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272395AbTHEDJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:09:26 -0400
Received: from hancock.siteprotect.com ([64.41.120.29]:56450 "EHLO
	hancock.siteprotect.com") by vger.kernel.org with ESMTP
	id S272393AbTHEDJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:09:18 -0400
Date: Mon, 4 Aug 2003 21:55:43 -0500
From: Dee <dfisher@uptimedevices.com>
To: linux-kernel@vger.kernel.org
Subject: usb oops palm-link sony clie
Message-Id: <20030804215543.6b718d0d.dfisher@uptimedevices.com>
Organization: Uptime Devices
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	when syncing at the end it hangs palm-link and the oops happens.
I have to reboot to get it to reset.



ksymoops 2.4.8 on i686 2.4.21-bk19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-bk19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address
000009a4*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c8a65ee4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c5770090   ecx: c77c6000   edx: 00000000
esi: 00000002   edi: c5770000   ebp: 00000000   esp: c77c7f4c
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 49, stackpage=c77c7000)
Stack: c8a67280 c5b39780 c8a672a0 c8a4deaf c56cd000 c5770000 00000100
00000001       c7ef0c00 00000000 00000000 c56cd000 c8a5021e c7ef0d10
00000000 00000001       c7ef0c00 c7b36860 00000000 c7b36888 0000000a
c8a504bd c7b36860 00000000 Call Trace:    [<c8a67280>] [<c8a672a0>]
[<c8a4deaf>] [<c8a5021e>] [<c8a504bd>]  [<c8a50677>] [<c0107028>]
Code: c7 80 a4 09 00 00 00 00 00 00 8d 4b 5c ff 43 5c 0f 8e d8 03
Error (Oops_bfd_perror): set_section_contents Bad value


>>EIP; c8a65ee4 <[hid]hid_init+14/2c>   <=====

>>ebx; c5770090 <_end+537d328/8645298>
>>ecx; c77c6000 <_end+73d3298/8645298>
>>edi; c5770000 <_end+537d298/8645298>
>>esp; c77c7f4c <_end+73d51e4/8645298>

Trace; c8a67280 <[hid]hiddev_connect+40/148>
Trace; c8a672a0 <[hid]hiddev_connect+60/148>
Trace; c8a4deaf <[usbcore]usb_disconnect+87/124>
Trace; c8a5021e <[usbcore]usb_hub_port_connect_change+4a/208>
Trace; c8a504bd <[usbcore]usb_hub_events+e1/268>
Trace; c8a50677 <[usbcore]usb_hub_thread+33/a8>
Trace; c0107028 <arch_kernel_thread+28/38>


1 warning and 1 error issued.  Results may not be reliable.




