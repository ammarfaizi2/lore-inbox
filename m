Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbULITYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbULITYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbULITYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:24:43 -0500
Received: from [206.71.178.18] ([206.71.178.18]:17845 "EHLO storix.com")
	by vger.kernel.org with ESMTP id S261585AbULITYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:24:35 -0500
Subject: initrd and fc3
From: rich turner <rich@storix.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1102620480.19320.8.camel@rich>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Dec 2004 11:28:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am testing fc3 by using an old-school initrd. by old-school i mean not
the new initramfs/cpio type initrd. the process i use to create the
initrd works for all other distributions (suse, mandrake, debian, fc2,
2.2.x, 2.4.x, 2.6.x, etc) but fails with fc3 (2.6.9-1.667).

upon system boot, the kernel executes, checks to see if the initrd is
initramfs (it isnt), finds the initrd (ext2), mounts it, and then
immediately exits without executing linuxrc.

anyone have any ideas as to why linuxrc is not being executed?

