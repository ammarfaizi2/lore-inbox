Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTK3RhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbTK3RhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:37:14 -0500
Received: from smta01.mail.ozemail.net ([203.103.165.50]:4781 "EHLO
	smta01.mail.ozemail.net") by vger.kernel.org with ESMTP
	id S264974AbTK3RhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:37:04 -0500
Subject: kernel 2.6.0-test10 panic, VFS mount root failed
From: James Buchanan <jamesb.au@acm.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Dec 2003 04:37:39 +1100
Message-Id: <1070213861.6254.7.camel@redhat.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I keep getting a 2.6.0-test10 kernel panic when VFS attempts to mount
the root filesystem.

In my grub script I have:
root (hd0,1)
kernel /boot/vmlinuz-2.6.0-test10 ro root=/dev/hda2

which is correct for my system.  The kernel then panics and tells me
'hda2' is not good and to pass a correct boot= option to the kernel. 
The exact message doesn't mean anything to me - it doesn't say something
like 'don't have ext3 fs compiled in.'

My RedHat Linux 8 system boots fine on the same partition with
boot=LABEL=/.  I thought it could have been that I didn't compile ext3
into the kernel, but after double checking, yes it's there.  That's all
I can think of, is there something else I might be missing?

Thanks,
James

