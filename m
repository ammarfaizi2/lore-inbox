Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTEUIRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTEUHzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:55:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261788AbTEUHna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:30 -0400
Message-ID: <20030521011420.57175.qmail@web40805.mail.yahoo.com>
Date: Tue, 20 May 2003 18:14:20 -0700 (PDT)
From: Mark Dascher <strogian@yahoo.com>
Subject: rootfs and /dev/root
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious about the two entries in /proc/mounts:
rootfs and /dev/root.  Although I don't have much
experience with this, I've looked through some of the
kernel source code (e.g. fs/namespace.c or
init/do_mounts.c).  All I can come up with (actually,
this is pretty much what I thought before I looked at
any code) is that rootfs is purely a kernel-generated
filesystem.  The kernel creates the /dev/root device
there, and then mounts /dev/root at / (replacing
rootfs).

There were some mentions of 'initrd' too, so I'm not
sure if I'm confusing rootfs with an initrd.  Could
anyone clear this up for me?


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
