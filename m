Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTBQGy5>; Mon, 17 Feb 2003 01:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTBQGy5>; Mon, 17 Feb 2003 01:54:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13961 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266868AbTBQGy5>; Mon, 17 Feb 2003 01:54:57 -0500
Date: Sun, 16 Feb 2003 23:04:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ext3 clings to you like flypaper
Message-ID: <78320000.1045465489@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added a journal to my root disk.
Mounted it ext3.
Found it scaled like crap
set my fstab back to ext2
/dev/sda2       /               ext2    defaults,errors=remount-ro      0   1
reboot.
Disk says it's mounted ext2 ("mount\n")
Still performs like crap.

Mmmmm ... it STILL mounts ext3.
Allegedly this is a "feature".
Can we please remove this stupidity?

If I say I want ext2, I want ext2 ....

M.

