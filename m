Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSKLQwl>; Tue, 12 Nov 2002 11:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSKLQwl>; Tue, 12 Nov 2002 11:52:41 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:9706 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261317AbSKLQwl>; Tue, 12 Nov 2002 11:52:41 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE][PATCH] 2.5.46: access permission filesystem 0.11
Date: Tue, 12 Nov 2002 17:59:12 +0100
Message-ID: <877kfin2qn.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new permission managing file system. Furthermore, it
adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- moved locking from spinlock to semaphore

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs/>

Regards, Olaf.
