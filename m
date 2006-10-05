Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWJEWGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWJEWGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWJEWGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:06:24 -0400
Received: from c-71-197-74-6.hsd1.ca.comcast.net ([71.197.74.6]:17065 "EHLO
	nofear.bounceme.net") by vger.kernel.org with ESMTP id S932329AbWJEWGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:06:23 -0400
Message-ID: <452581D7.5020907@syphir.sytes.net>
Date: Thu, 05 Oct 2006 15:06:15 -0700
From: "C.Y.M" <syphir@syphir.sytes.net>
Reply-To: syphir@syphir.sytes.net
Organization: CooLNeT
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: warning at fs/inotify.c:181 with linux-2.6.18
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I updated to 2.6.18, I have had the following warnings in my syslog.  Is
this a known problem? Better yet, is there a solution to this?  I am running on
a i686 (Athlon XP) 32 bit cpu compiled under gcc-3.4.6.


Oct  5 08:27:31 sid kernel: BUG: warning at
fs/inotify.c:181/set_dentry_child_flags()
Oct  5 08:27:31 sid kernel:  [<c0182a10>] set_dentry_child_flags+0x170/0x190
Oct  5 08:27:31 sid kernel:  [<c0182adf>] remove_watch_no_event+0x5f/0x70
Oct  5 08:27:31 sid kernel:  [<c0182b08>] inotify_remove_watch_locked+0x18/0x50
Oct  5 08:27:31 sid kernel:  [<c01833dc>] inotify_rm_wd+0x6c/0xb0
Oct  5 08:27:31 sid kernel:  [<c0183e98>] sys_inotify_rm_watch+0x38/0x60
Oct  5 08:27:31 sid kernel:  [<c0102d8f>] syscall_call+0x7/0xb


Best Regards.
