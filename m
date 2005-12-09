Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVLIOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVLIOXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVLIOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:23:04 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:38350 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S932108AbVLIOXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:23:01 -0500
Message-ID: <0C6AA2145B810F499C69B0947DC5078105F7959B@oh0012exch001p.cb.lucent.com>
From: "Gupta, Deepak (Deepak)" <deepakgupta@lucent.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Linux 2.6 Partition Compat Bug??
Date: Fri, 9 Dec 2005 09:22:59 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



All,

I am trying to mount UnixWare slices on Linux 2.6 and I see that the kernel I am running has the following configured:

CONFIG_UNIXWARE_DISKLABEL=y

My system currently has a few logical disks which have UnixWare slices on them (vxfs), and when I try to mount these, I only see a single partition (sdd4 for e.g.) that says GNU HURD or SYSV (which is expected).  And I do not see any other device under /dev that might pertain to the UnixWare slices.  My questions:

1.   What does configuring in the unixware slice support in Linux mean?  Is this a bug that compatibility is claimed but does not actually exist?

Many thanks for your time,

-Deepak

 
-
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
