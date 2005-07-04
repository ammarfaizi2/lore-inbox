Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVGDRpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVGDRpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 13:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGDRpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 13:45:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47764 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261498AbVGDRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 13:45:01 -0400
Date: Mon, 4 Jul 2005 09:47:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.32-pre1
Message-ID: <20050704124753.GA23706@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the first -pre of v2.4.32. 

It contains a small amount of fixes, most notably x86_64 security updates.


Check for canonical addresses in ptrace (CAN-2005-1762)
Fix canonical checking for segment registers in ptrace (CAN-2005-0756)
Fix buffer overflow in 32bit execve on x86-64/ia64 (CAN-2005-1768)


Summary of changes from v2.4.31 to v2.4.32-pre1
============================================

Andi Kleen <ak@suse.de>:
  x86-64: Enable Nvidia timer override workaround for SMP kernels too
  x86-64: Fix build with !CONFIG_SWIOTLB
  x86_64: Disable exception stack for stack faults
  Fix canonical checking for segment registers in ptrace
  Check for canonical addresses in ptrace
  Fix buffer overflow in x86-64/ia64 32bit execve

David S. Miller <davem@davemloft.net>:
  [NETLINK]: Fix two socket hashing bugs.
  [SPARC64]: Fix cmsg length checks in Solaris emulation layer.
  [SPARC64]: Fix conflicting __bzero_noasi() prototypes.

H. J. Lu <hjl@lucon.org>:
  newer i386/x86_64 assemblers prohibit instructions for moving between a seg register and a 32bit location

Marcel Holtmann <marcel@holtmann.org>:
  Fix" introduced in 2.4.27pre2 for bluetooth hci_usb race causes kernel hang

Marcelo <marcelo@xeon.cnet>:
  Change VERSION to 2.4.32-pre1

NeilBrown <neilb@cse.unsw.edu.au>:
  Claim i_alloc_sem while changing file size in nfsd
  Don't drop setuid on directories when ownership changed by NFSd

Pete Zaitcev <zaitcev@redhat.com>:
  USB 2.4.31: ftdi_sio fixes

Ralf Baechle <ralf@linux-mips.org>:
  update netdev address

