Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270877AbTGPKWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270878AbTGPKWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:22:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29715 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270877AbTGPKWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:22:07 -0400
Date: Wed, 16 Jul 2003 11:36:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: IPv6 warnings
Message-ID: <20030716113657.A24009@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.0-test1 (src@tika) (gcc version 3.2.2 20030313
 (Red Hat Linux 3.2.2-10_rmk1)) #1280 Wed Jul 16 11:07:22 BST 2003
CPU: StrongARM-1110 [6901b118] revision 8 (ARMv4)

I'm running IPv6 the above, and I'm seeing the following messages.
ipv6 was built as a module.  Should I be worried?

IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Destroying alive neighbour c18c2a44
[<c015bb84>] (dst_destroy+0x0/0x168) from [<bf00d024>] (ndisc_dst_gc+0x74/0xa4 [ipv6])
[<bf00cfb0>] (ndisc_dst_gc+0x0/0xa4 [ipv6]) from [<bf010e1c>] (fib6_run_gc+0x70/0x160 [ipv6])
[<bf010dac>] (fib6_run_gc+0x0/0x160 [ipv6]) from [<c0041328>] (run_timer_softirq+0x134/0x238)
[<c00411f4>] (run_timer_softirq+0x0/0x238) from [<c003ca14>] (do_softirq+0xf8/0x108)
[<c003c91c>] (do_softirq+0x0/0x108) from [<c00212e8>] (__do_softirq+0x8/0x20)
[<c00222c8>] (asm_do_IRQ+0x0/0xdc) from [<c0020eb4>] (__irq_svc+0x34/0xac)
[<c0022e70>] (cpu_idle+0x0/0xb8) from [<c0008744>] (start_kernel+0x170/0x1b4)
[<c00085d4>] (start_kernel+0x0/0x1b4) from [<c0008080>] (__mmap_switched+0x0/0x2c)
Destroying alive neighbour c18c2a44
[<c00411f4>] (run_timer_softirq+0x0/0x238) from [<c003ca14>] (do_softirq+0xf8/0x108)
[<c003c91c>] (do_softirq+0x0/0x108) from [<c00212e8>] (__do_softirq+0x8/0x20)
[<c00222c8>] (asm_do_IRQ+0x0/0xdc) from [<c0020eb4>] (__irq_svc+0x34/0xac)
[<c0022e70>] (cpu_idle+0x0/0xb8) from [<c0008744>] (start_kernel+0x170/0x1b4)
[<c00085d4>] (start_kernel+0x0/0x1b4) from [<c0008080>] (__mmap_switched+0x0/0x2c)
Destroying alive neighbour c18c2c18
[<c015bb84>] (dst_destroy+0x0/0x168) from [<bf0107bc>] (fib6_del_route+0x180/0x280 [ipv6])
[<bf01063c>] (fib6_del_route+0x0/0x280 [ipv6]) from [<bf010968>] (fib6_del+0xac/0xe4 [ipv6])
[<bf0108bc>] (fib6_del+0x0/0xe4 [ipv6]) from [<bf010c6c>] (fib6_clean_node+0x78/0xa4 [ipv6])
[<bf010bf4>] (fib6_clean_node+0x0/0xa4 [ipv6]) from [<bf010ad4>] (fib6_walk_continue+0x134/0x158 [ipv6])
[<bf0109a0>] (fib6_walk_continue+0x0/0x158 [ipv6]) from [<bf010b78>] (fib6_walk+0x80/0xfc [ipv6])
[<bf010af8>] (fib6_walk+0x0/0xfc [ipv6]) from [<bf010ccc>] (fib6_clean_tree+0x34/0x3c [ipv6])
[<bf010c98>] (fib6_clean_tree+0x0/0x3c [ipv6]) from [<bf010e30>] (fib6_run_gc+0x84/0x160 [ipv6])
[<bf010dac>] (fib6_run_gc+0x0/0x160 [ipv6]) from [<c0041328>] (run_timer_softirq+0x134/0x238)
[<c00411f4>] (run_timer_softirq+0x0/0x238) from [<c003ca14>] (do_softirq+0xf8/0x108)
[<c003c91c>] (do_softirq+0x0/0x108) from [<c00212e8>] (__do_softirq+0x8/0x20)
[<c00222c8>] (asm_do_IRQ+0x0/0xdc) from [<c0020eb4>] (__irq_svc+0x34/0xac)
[<c0022e70>] (cpu_idle+0x0/0xb8) from [<c0008744>] (start_kernel+0x170/0x1b4)
[<c00085d4>] (start_kernel+0x0/0x1b4) from [<c0008080>] (__mmap_switched+0x0/0x2c)
Destroying alive neighbour c18c2084
[<c015bb84>] (dst_destroy+0x0/0x168) from [<bf00d024>] (ndisc_dst_gc+0x74/0xa4 [ipv6])
[<bf00cfb0>] (ndisc_dst_gc+0x0/0xa4 [ipv6]) from [<bf010e1c>] (fib6_run_gc+0x70/0x160 [ipv6])
[<bf010dac>] (fib6_run_gc+0x0/0x160 [ipv6]) from [<c0041328>] (run_timer_softirq+0x134/0x238)
[<c00411f4>] (run_timer_softirq+0x0/0x238) from [<c003ca14>] (do_softirq+0xf8/0x108)
[<c003c91c>] (do_softirq+0x0/0x108) from [<c00212e8>] (__do_softirq+0x8/0x20)
[<c00222c8>] (asm_do_IRQ+0x0/0xdc) from [<c0020eb4>] (__irq_svc+0x34/0xac)
[<c0022e70>] (cpu_idle+0x0/0xb8) from [<c0008744>] (start_kernel+0x170/0x1b4)
[<c00085d4>] (start_kernel+0x0/0x1b4) from [<c0008080>] (__mmap_switched+0x0/0x2c)
Destroying alive neighbour c18c2084
[<bf013ee0>] (ndisc_recv_ns+0x0/0x784 [ipv6]) from [<bf015820>] (ndisc_rcv+0xc0/0x11c [ipv6])
[<bf015760>] (ndisc_rcv+0x0/0x11c [ipv6]) from [<bf01bda0>] (icmpv6_rcv+0x2f8/0x780 [ipv6])
[<bf01baa8>] (icmpv6_rcv+0x0/0x780 [ipv6]) from [<bf005ee0>] (ip6_input+0x16c/0x368 [ipv6])
[<bf005d74>] (ip6_input+0x0/0x368 [ipv6]) from [<bf005cd8>] (ipv6_rcv+0x1e4/0x280 [ipv6])
[<bf005af4>] (ipv6_rcv+0x0/0x280 [ipv6]) from [<c01585c4>] (netif_receive_skb+0x1d8/0x290)
[<c01583ec>] (netif_receive_skb+0x0/0x290) from [<c0158720>] (process_backlog+0xa4/0x18c)
[<c015867c>] (process_backlog+0x0/0x18c) from [<c01588b0>] (net_rx_action+0xa8/0x1b4)
[<c0158808>] (net_rx_action+0x0/0x1b4) from [<c003ca14>] (do_softirq+0xf8/0x108)
[<c003c91c>] (do_softirq+0x0/0x108) from [<c00212e8>] (__do_softirq+0x8/0x20)
[<c00222c8>] (asm_do_IRQ+0x0/0xdc) from [<c0020eb4>] (__irq_svc+0x34/0xac)
[<c0022e70>] (cpu_idle+0x0/0xb8) from [<c0008744>] (start_kernel+0x170/0x1b4)
[<c00085d4>] (start_kernel+0x0/0x1b4) from [<c0008080>] (__mmap_switched+0x0/0x2c)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

