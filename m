Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264230AbTIIQhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTIIQhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:37:15 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:34197 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S264230AbTIIQhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:37:10 -0400
Message-ID: <3F5E01B4.3050507@terra.com.br>
Date: Tue, 09 Sep 2003 13:37:08 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill unneeded include in net/sched
Content-Type: multipart/mixed;
 boundary="------------000909010606030501090604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909010606030501090604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew,

	This patch (against 2.6-test5) kills all the remaining code that 
Randy's checkversion.pl said was using linux/version.h unnecessary on 
net/sched.

	Please apply.

	Cheers,

Felipe

--------------000909010606030501090604
Content-Type: text/plain;
 name="net_sched-checkversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net_sched-checkversion.patch"

diff -u -rN linux-2.6.0-test5/net/sched/sch_htb.c linux-2.6.0-test5-fwd/net/sched/sch_htb.c
--- linux-2.6.0-test5/net/sched/sch_htb.c	Mon Sep  8 16:50:08 2003
+++ linux-2.6.0-test5-fwd/net/sched/sch_htb.c	Tue Sep  9 11:58:01 2003
@@ -32,7 +32,6 @@
 #include <asm/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/mm.h>

--------------000909010606030501090604--

