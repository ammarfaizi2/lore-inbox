Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131634AbRC0VlR>; Tue, 27 Mar 2001 16:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRC0Vk5>; Tue, 27 Mar 2001 16:40:57 -0500
Received: from ipn2-a1131.net-resource.net ([216.204.61.131]:40771 "EHLO
	intranet.chipwrights.com") by vger.kernel.org with ESMTP
	id <S131595AbRC0Vkt>; Tue, 27 Mar 2001 16:40:49 -0500
Message-ID: <3AC108AF.C5F4A862@chipwrights.com>
Date: Tue, 27 Mar 2001 16:39:59 -0500
From: Clem Taylor <ctaylor@chipwrights.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 SMP + 3c905C-TX + NETDEV WATCHDOG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every few weeks, since switching to 2.4.2, I get a series of 'NETDEV
WATCHDOG' errors. When this happens the system becomes unusable (homes
are NFS mounted) and does not recover. A small number of packets do get
out when it's in this state, but not enough to be useful. I've tried an
ifconfig up/down, all that seems to help is a reboot. The 3c905C driver
is compiled into my kernel, so I can't reload it. The machine is a Dell
Precision 220 (only one processor installed).

Has anyone else seen this problem. Is their a way to reset the interface
without rebooting? Any ideas?

                    Many thanks,
                    Clem

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0cfc media 8880 dma 0000003a.
eth0: Interrupt posted but not delivered -- IRQ blocked by another
device?
  Flags; bus-master 1, full 0; dirty 1172221(13) current 1172221(13).
  Transmit list 00000000 vs. c14ca2d0.
  0: @c14ca200  length 8000002a status 0001002a
  1: @c14ca210  length 8000008e status 0001008e
  2: @c14ca220  length 800000ae status 000100ae
  3: @c14ca230  length 8000006e status 0001006e
  4: @c14ca240  length 800000ae status 000100ae
  5: @c14ca250  length 800000ae status 000100ae
  6: @c14ca260  length 8000004a status 0001004a
  7: @c14ca270  length 8000008e status 0001008e
  8: @c14ca280  length 800000ae status 000100ae
  9: @c14ca290  length 8000002a status 0001002a
  10: @c14ca2a0  length 8000002a status 0001002a
  11: @c14ca2b0  length 8000004a status 8001004a
  12: @c14ca2c0  length 8000002a status 8001002a
  13: @c14ca2d0  length 80000042 status 00010042
  14: @c14ca2e0  length 800000ae status 000100ae
  15: @c14ca2f0  length 80000042 status 00010042
eth0: Resetting the Tx ring pointer.
