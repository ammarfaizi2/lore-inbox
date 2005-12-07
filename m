Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVLGQM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVLGQM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVLGQM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:12:58 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:43187 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP
	id S1751173AbVLGQM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:12:57 -0500
Message-ID: <0C6AA2145B810F499C69B0947DC5078105F79584@oh0012exch001p.cb.lucent.com>
From: "Gupta, Deepak (Deepak)" <deepakgupta@lucent.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Mounting UnixWare vxfs Partitions/Slices on Linux 2.6?
Date: Wed, 7 Dec 2005 11:12:52 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



All,

I am trying to mount UnixWare slices on Linux 2.6 and I see that the kernel I am running has the following configured:

CONFIG_UNIXWARE_DISKLABEL=y

My system currently has a few logical disks which have UnixWare slices on them (vxfs), and when I try to mount these, I only see a single partition (sdd4 for e.g.) that says GNU HURD or SYSV (which is expected).  And I do not see any other device under /dev that might pertain to the UnixWare slices.  My questions:

1.   What does configuring in the unixware slice support in Linux mean, w.r.t devices in /dev?

2.   How do I mount these slices, I have freevxfs support.

Thanks in advance for any pointers,

-Deepak

 
