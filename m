Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbTICO2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbTICO2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:28:20 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:41904 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262408AbTICO2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:28:15 -0400
Message-ID: <3F55FAD8.6010003@terra.com.br>
Date: Wed, 03 Sep 2003 11:29:44 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kill unneeded version.h from net/sched
Content-Type: multipart/mixed;
 boundary="------------090907080600050706040806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090907080600050706040806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	Last patch, removing all references that checkversion gave me on net/

	Against 2.6-test4, please apply.

	Cheers

Felipe

--------------090907080600050706040806
Content-Type: text/plain;
 name="net_sched-checkversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net_sched-checkversion.patch"

--- linux-2.6.0-test4/net/sched/sch_htb.c	Fri Aug 22 20:57:14 2003
+++ linux-2.6.0-test4-fwd/net/sched/sch_htb.c	Wed Sep  3 11:27:06 2003
@@ -32,7 +32,6 @@
 #include <asm/bitops.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/mm.h>

--------------090907080600050706040806--

