Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272228AbTGYRfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272229AbTGYRff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:35:35 -0400
Received: from dialpool-210-214-166-187.maa.sify.net ([210.214.166.187]:50584
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S272228AbTGYRfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:35:32 -0400
Date: Fri, 25 Jul 2003 23:21:41 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Has this been fixed yet?
Message-ID: <20030725175141.GA3290@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted before but nobody seems to have read it.
I get his _every_time_ I unload emu10k1 (OSS) module on 2.6.0-test1:

Call Trace:
[<c018e261>] devfs_remove+0x9e/0xa0
[<c013898a>] unmap_vmas+0xcb/0x214
[<d29e3e2d>] oss_cleanup+0x2b/0xed [sound]
[<c0129c1e>] sys_delete_module+0x152/0x1a8
[<c0130064>] generic_file_aio_write_nolock+0x8a7/0xa6a
[<c013be3c>] sys_munmap+0x57/0x75
[<c0108f81>] sysenter_past_esp+0x52/0x71 

And I'm not using devfs.
