Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758402AbWLEBCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758402AbWLEBCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 20:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967939AbWLEBCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 20:02:45 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:42256 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758404AbWLEBCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 20:02:44 -0500
Date: Mon, 4 Dec 2006 17:03:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: netdev <netdev@vger.kernel.org>
Subject: 2.6.19-git6 header error
Message-Id: <20061204170324.41fedf13.randy.dunlap@oracle.com>
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

linux-2.6.19-git6/usr/include/linux/netfilter.h requires linux/rcupdate.h, which does not exist in exported headers
make[3]: *** [/var/linsrc/linux-2.6.19-git6/usr/include/linux/.check.netfilter.h] Error 1
make[2]: *** [linux] Error 2
make[1]: *** [headers_check] Error 2
make: *** [vmlinux] Error 2

---
~Randy
