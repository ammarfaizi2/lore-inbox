Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423150AbWJQGkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423150AbWJQGkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423152AbWJQGkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:40:08 -0400
Received: from holoclan.de ([62.75.158.126]:43948 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1423150AbWJQGkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:40:05 -0400
Date: Tue, 17 Oct 2006 08:37:10 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 - another DWARF2
Message-ID: <20061017063710.GA27139@gimli>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  just got the following on resume: [87026.242000] usb
	4-2: USB disconnect, address 18 [87026.448000] usb 4-2: new full speed
	USB device using uhci_hcd and address 20 [87026.613000] usb 4-2:
	configuration #1 chosen from 1 choice [87026.704000] IRQ handler type
	mismatch for IRQ 90 [87026.704000] [<c0103d7c>]
	show_trace_log_lvl+0x5b/0x16d [87026.704000] [<c01044cb>]
	show_trace+0xf/0x11 [87026.705000] [<c01045ce>] dump_stack+0x15/0x17
	[87026.705000] [<c01403d7>] setup_irq+0x17d/0x190 [87026.705000]
	[<c0140466>] request_irq+0x7c/0x98 [87026.706000] [<c0251745>]
	e1000_open+0xcd/0x1a4 [87026.707000] [<c029565c>] dev_open+0x2b/0x62
	[87026.708000] [<c0294181>] dev_change_flags+0x47/0xe4 [87026.709000]
	[<c02c7cd1>] devinet_ioctl+0x252/0x556 [87026.711000] [<c028b5a3>]
	sock_ioctl+0x19a/0x1be [87026.712000] [<c016b6af>] do_ioctl+0x1f/0x62
	[87026.712000] [<c016b937>] vfs_ioctl+0x245/0x257 [87026.713000]
	[<c016b995>] sys_ioctl+0x4c/0x67 [87026.714000] [<c0102db3>]
	syscall_call+0x7/0xb [87026.714000] DWARF2 unwinder stuck at
	syscall_call+0x7/0xb [87026.715000] Leftover inexact backtrace:
	[87026.715000] e1000: eth0: e1000_request_irq: Unable to allocate
	interrupt Error: -16 [87027.026000] usb 4-1: new full speed USB device
	using uhci_hcd and address 21 [87027.055000] ata1: waiting for device to
	spin up (7 secs) [87027.186000] usb 4-1: configuration #1 chosen from 1
	choice [87027.757000] IRQ handler type mismatch for IRQ 98
	[87027.757000] [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d [87027.757000]
	[<c01044cb>] show_trace+0xf/0x11 [87027.758000] [<c01045ce>]
	dump_stack+0x15/0x17 [87027.758000] [<c01403d7>] setup_irq+0x17d/0x190
	[87027.758000] [<c0140466>] request_irq+0x7c/0x98 [87027.759000]
	[<c0251745>] e1000_open+0xcd/0x1a4 [87027.760000] [<c029565c>]
	dev_open+0x2b/0x62 [87027.761000] [<c0294181>]
	dev_change_flags+0x47/0xe4 [87027.762000] [<c02c7cd1>]
	devinet_ioctl+0x252/0x556 [87027.764000] [<c028b5a3>]
	sock_ioctl+0x19a/0x1be [87027.765000] [<c016b6af>] do_ioctl+0x1f/0x62
	[87027.766000] [<c016b937>] vfs_ioctl+0x245/0x257 [87027.766000]
	[<c016b995>] [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just got the following on resume:

[87026.242000] usb 4-2: USB disconnect, address 18
[87026.448000] usb 4-2: new full speed USB device using uhci_hcd and address
20
[87026.613000] usb 4-2: configuration #1 chosen from 1 choice
[87026.704000] IRQ handler type mismatch for IRQ 90
[87026.704000]  [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d
[87026.704000]  [<c01044cb>] show_trace+0xf/0x11
[87026.705000]  [<c01045ce>] dump_stack+0x15/0x17
[87026.705000]  [<c01403d7>] setup_irq+0x17d/0x190
[87026.705000]  [<c0140466>] request_irq+0x7c/0x98
[87026.706000]  [<c0251745>] e1000_open+0xcd/0x1a4
[87026.707000]  [<c029565c>] dev_open+0x2b/0x62
[87026.708000]  [<c0294181>] dev_change_flags+0x47/0xe4
[87026.709000]  [<c02c7cd1>] devinet_ioctl+0x252/0x556
[87026.711000]  [<c028b5a3>] sock_ioctl+0x19a/0x1be
[87026.712000]  [<c016b6af>] do_ioctl+0x1f/0x62
[87026.712000]  [<c016b937>] vfs_ioctl+0x245/0x257
[87026.713000]  [<c016b995>] sys_ioctl+0x4c/0x67
[87026.714000]  [<c0102db3>] syscall_call+0x7/0xb
[87026.714000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[87026.715000] Leftover inexact backtrace:
[87026.715000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[87027.026000] usb 4-1: new full speed USB device using uhci_hcd and address
21
[87027.055000] ata1: waiting for device to spin up (7 secs)
[87027.186000] usb 4-1: configuration #1 chosen from 1 choice
[87027.757000] IRQ handler type mismatch for IRQ 98
[87027.757000]  [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d
[87027.757000]  [<c01044cb>] show_trace+0xf/0x11
[87027.758000]  [<c01045ce>] dump_stack+0x15/0x17
[87027.758000]  [<c01403d7>] setup_irq+0x17d/0x190
[87027.758000]  [<c0140466>] request_irq+0x7c/0x98
[87027.759000]  [<c0251745>] e1000_open+0xcd/0x1a4
[87027.760000]  [<c029565c>] dev_open+0x2b/0x62
[87027.761000]  [<c0294181>] dev_change_flags+0x47/0xe4
[87027.762000]  [<c02c7cd1>] devinet_ioctl+0x252/0x556
[87027.764000]  [<c028b5a3>] sock_ioctl+0x19a/0x1be
[87027.765000]  [<c016b6af>] do_ioctl+0x1f/0x62
[87027.766000]  [<c016b937>] vfs_ioctl+0x245/0x257
[87027.766000]  [<c016b995>] sys_ioctl+0x4c/0x67
[87027.767000]  [<c0102db3>] syscall_call+0x7/0xb
[87027.767000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[87027.767000] Leftover inexact backtrace:
[87027.767000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[87028.810000] IRQ handler type mismatch for IRQ 106
[87028.810000]  [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d
[87028.810000]  [<c01044cb>] show_trace+0xf/0x11
[87028.811000]  [<c01045ce>] dump_stack+0x15/0x17
[87028.811000]  [<c01403d7>] setup_irq+0x17d/0x190
[87028.811000]  [<c0140466>] request_irq+0x7c/0x98
[87028.812000]  [<c0251745>] e1000_open+0xcd/0x1a4
[87028.813000]  [<c029565c>] dev_open+0x2b/0x62
[87028.814000]  [<c0294181>] dev_change_flags+0x47/0xe4
[87028.815000]  [<c02c7cd1>] devinet_ioctl+0x252/0x556
[87028.817000]  [<c028b5a3>] sock_ioctl+0x19a/0x1be
[87028.818000]  [<c016b6af>] do_ioctl+0x1f/0x62
[87028.818000]  [<c016b937>] vfs_ioctl+0x245/0x257
[87028.819000]  [<c016b995>] sys_ioctl+0x4c/0x67
[87028.820000]  [<c0102db3>] syscall_call+0x7/0xb
[87028.820000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[87028.820000] Leftover inexact backtrace:
[87028.820000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[87029.863000] IRQ handler type mismatch for IRQ 114
[87029.863000]  [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d
[87029.863000]  [<c01044cb>] show_trace+0xf/0x11
[87029.864000]  [<c01045ce>] dump_stack+0x15/0x17
[87029.864000]  [<c01403d7>] setup_irq+0x17d/0x190
[87029.864000]  [<c0140466>] request_irq+0x7c/0x98
[87029.865000]  [<c0251745>] e1000_open+0xcd/0x1a4
[87029.866000]  [<c029565c>] dev_open+0x2b/0x62
[87029.867000]  [<c0294181>] dev_change_flags+0x47/0xe4
[87029.868000]  [<c02c7cd1>] devinet_ioctl+0x252/0x556
[87029.870000]  [<c028b5a3>] sock_ioctl+0x19a/0x1be
[87029.871000]  [<c016b6af>] do_ioctl+0x1f/0x62
[87029.871000]  [<c016b937>] vfs_ioctl+0x245/0x257
[87029.872000]  [<c016b995>] sys_ioctl+0x4c/0x67
[87029.873000]  [<c0102db3>] syscall_call+0x7/0xb
[87029.873000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[87029.873000] Leftover inexact backtrace:
[87029.873000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[87030.917000] IRQ handler type mismatch for IRQ 122
[87030.917000]  [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d
[87030.917000]  [<c01044cb>] show_trace+0xf/0x11
[87030.918000]  [<c01045ce>] dump_stack+0x15/0x17
[87030.918000]  [<c01403d7>] setup_irq+0x17d/0x190
[87030.918000]  [<c0140466>] request_irq+0x7c/0x98
[87030.919000]  [<c0251745>] e1000_open+0xcd/0x1a4
[87030.920000]  [<c029565c>] dev_open+0x2b/0x62
[87030.921000]  [<c0294181>] dev_change_flags+0x47/0xe4
[87030.922000]  [<c02c7cd1>] devinet_ioctl+0x252/0x556
[87030.924000]  [<c028b5a3>] sock_ioctl+0x19a/0x1be
[87030.925000]  [<c016b6af>] do_ioctl+0x1f/0x62
[87030.925000]  [<c016b937>] vfs_ioctl+0x245/0x257
[87030.926000]  [<c016b995>] sys_ioctl+0x4c/0x67
[87030.927000]  [<c0102db3>] syscall_call+0x7/0xb
[87030.927000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[87030.927000] Leftover inexact backtrace:
[87030.927000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[87031.970000] IRQ handler type mismatch for IRQ 130
[87031.970000]  [<c0103d7c>] show_trace_log_lvl+0x5b/0x16d
[87031.970000]  [<c01044cb>] show_trace+0xf/0x11
[87031.971000]  [<c01045ce>] dump_stack+0x15/0x17
[87031.971000]  [<c01403d7>] setup_irq+0x17d/0x190
[87031.971000]  [<c0140466>] request_irq+0x7c/0x98
[87031.972000]  [<c0251745>] e1000_open+0xcd/0x1a4
[87031.973000]  [<c029565c>] dev_open+0x2b/0x62
[87031.974000]  [<c0294181>] dev_change_flags+0x47/0xe4
[87031.975000]  [<c02c7cd1>] devinet_ioctl+0x252/0x556
[87031.977000]  [<c028b5a3>] sock_ioctl+0x19a/0x1be
[87031.978000]  [<c016b6af>] do_ioctl+0x1f/0x62
[87031.978000]  [<c016b937>] vfs_ioctl+0x245/0x257
[87031.979000]  [<c016b995>] sys_ioctl+0x4c/0x67
[87031.980000]  [<c0102db3>] syscall_call+0x7/0xb
[87031.980000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[87031.980000] Leftover inexact backtrace:
[87031.980000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[87034.525000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

full dmesg is at 
http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.18-ie-la-tp-41.5+0813.boot
(boot time) and 
http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.18-ie-la-tp-41.5+0813.out
(runtime)

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
