Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUESObY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUESObY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUESO35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:29:57 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:42360 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264202AbUESO3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:29:08 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E256AB9C-A9A0-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: Maneesh Soni <maneesh@in.ibm.com>
From: Steven Cole <scole@lanl.gov>
Subject: 2.6.6-bk-current and no CONFIG_SYSFS gives lib/kobject.c:395: error: void value not ignored as it ought to be
Date: Wed, 19 May 2004 08:29:06 -0600
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the current 2.6.6-bk kernel, and without CONFIG_SYSFS,
I get this error:

   CC      lib/kobject.o
lib/kobject.c: In function `kobject_rename':
lib/kobject.c:395: error: void value not ignored as it ought to be
   CC      net/core/scm.o
make[1]: *** [lib/kobject.o] Error 1

With CONFIG_SYSFS=y, the kernel builds OK.

	Steven

