Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTL2AA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 19:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTL2AA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 19:00:28 -0500
Received: from pop.gmx.net ([213.165.64.20]:49622 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262356AbTL2AA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 19:00:27 -0500
X-Authenticated: #20450766
Date: Mon, 29 Dec 2003 00:59:13 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Reiserfs-3.6.25 (2.4.21) ., instead of .., rsync Q
Message-ID: <Pine.LNX.4.44.0312290046510.554-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

After running a machine for some time I've got an empty directory with

ls -a /var/run/sudo/user/ showing
.  .,

and

ls -al /var/run/sudo/user/
ls: /var/run/sudo/user/.,: No such file or directory
total 1
drwx------    2 root     root           48 Jan  1  1985 .

Hm, and the date above doesn't seem right too:-) S.M.A.R.T. didn't record
any errors on the disk.

Don't know if this would be of much help, though - I've already removed
the directory (rmdir worked ok), I had to do a backup, and with that
structure rsync couldn't go further.

BTW, unrelated - does anyone happen to know if using up 300M virtual
memory, and even leading to OOM is ok for rsync, when sync-ing large
data-volumes (20Gb)?

Thanks
Guennadi
---
Guennadi Liakhovetski



