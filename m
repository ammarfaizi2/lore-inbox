Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTIPNUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTIPNUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:20:51 -0400
Received: from proxy.ovh.net ([213.244.20.42]:20752 "EHLO proxy.ovh.net")
	by vger.kernel.org with ESMTP id S261869AbTIPNUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:20:49 -0400
Date: Tue, 16 Sep 2003 15:23:29 +0200
To: linux-kernel@vger.kernel.org
Subject: devfs err at boot
Message-ID: <20030916132329.GG19760@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: bert@ovh.net (bertrand)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I used a 2.4.21 to boot on lan and nfs root.

Recently, i got my box rebooting endless.

I have moved to 2.4.22 and i got that error : 

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 213.186.32.57
Looking up port of RPC 100005/1 on 213.186.32.57
VFS: Mounted root (nfs filesystem).
mount_devfs_fs(): unable to mount devfs, err: -2
Freeing unused kernel memory: 268k freed
Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init= option to kernel.
 

It's correctly mounting the nfsroot but if cannot mount the devfs .
The kernel got nfsroot , dhcp, devfs at boot .

I checked if there still was the /dev entry and it still was ...

Were can I found the meaning of "err: -2" ?

Do someone caught that error once ?

	Bert.
