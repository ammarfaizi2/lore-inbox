Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbULFUX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbULFUX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbULFUX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:23:58 -0500
Received: from thumper2.emsphone.com ([199.67.51.102]:54657 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S261639AbULFUX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:23:57 -0500
Date: Mon, 6 Dec 2004 14:23:56 -0600
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: Rereading disk geometry without reboot
Message-ID: <20041206202356.GA5866@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using linux kernel 2.6.9 on a san.  I have file systems on
non-partitioned disks.  I can resize the disk on the SAN, reboot and grow
the XFS file system those disks.  What I would like to avoid rebooting or
even unmounting the filesystem if possible.

Is there any way to get the kernel to re-read the disk geometry and change
the information it holds without rebooting or reloading the module (which is
as bad as a reboot in my case)?

Thanks,

Andy
