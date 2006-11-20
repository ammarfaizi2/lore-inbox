Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933778AbWKTAMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933778AbWKTAMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933799AbWKTAMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:12:21 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:15926 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933778AbWKTAMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:12:20 -0500
Date: Sun, 19 Nov 2006 16:12:31 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: xconfig segfault
Message-Id: <20061119161231.e509e5bf.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make xconfig is segfaulting on me in 2.6.19-rc6 and later
when I do ^F (find/search).
Works fine in 2.6.19-rc5 and earlier.

The only message log I get is:

qconf[5839]: segfault at 0000000000000008 rip 00000000004289bc rsp 00007fffa08ccf10 error 4

I don't see any changes in scripts/kconfig/* in 2.6.19-rc6.
Any ideas/suggestions?

Thanks,
---
~Randy
