Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVFTPqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFTPqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVFTPqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:46:31 -0400
Received: from animx.eu.org ([216.98.75.249]:4550 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261361AbVFTPoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:44:32 -0400
Date: Mon, 20 Jun 2005 12:01:52 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: umount of initramfs hangs 2.6.12
Message-ID: <20050620160152.GA6045@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject says it all actually.  No error messages, nothing.  sysrq is
the only thing that responds to me.

sysrq+p shows process umount.  EIP is at umount_tree+0x40/0x110
I assume the stuff below the registers is the stack.
do_munmap+0x11b/0x150
sys_munmap+0x44/0x70
do_umount+0x139/0x1e0
__user_walk+0x46/0x60
sys_umount+0x8d/0xa0
do_munmap+0x11b/0x150
sys_munmap+0x44/0x70
sys_oldumount+0x15/0x20
syscall_call+0x7/0xb

NOTE: The above was typed by hand.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
