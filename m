Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVCMMBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVCMMBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 07:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVCMMBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 07:01:47 -0500
Received: from zork.zork.net ([64.81.246.102]:31642 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261166AbVCMMBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 07:01:45 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: 2.6.11-mm3: machine check on sleep, PowerBook5.4
References: <20050312034222.12a264c4.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
Date: Sun, 13 Mar 2005 12:01:36 +0000
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 12 Mar 2005 03:42:22 -0800")
Message-ID: <6upsy37o0v.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine check in kernel mode.
Caused by (from SRR1=149030): Transfer error ack signal
Oops: machine check, sig: 7 [#1]
TASK = etc. 'pmud' etc.
(for registers and such, see:
 http://flynn.zork.net/~sneakums/pmac-machine-check-on-sleep-2611mm3.jpeg )
Call trace:
 pmac_ide_pci_suspend
 pci_device_suspend
 suspend_device
 device_suspend
 0xc03dd894
 0xc03dddb8
 0xc03de7cc
 do_ioctl
 vfs_ioctl
 sys_ioctl
 ret_from_syscall


-- 
Dag vijandelijk luchtschip de huismeester is dood
