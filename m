Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbTICOCv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbTICOCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:02:51 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:2483 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262079AbTICOCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:02:50 -0400
Message-ID: <3F55F4DD.9070301@terra.com.br>
Date: Wed, 03 Sep 2003 11:04:13 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: pekkas@netcore.fi, davem@redhat.com, yoshfuji@linux-ipv6.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: [PATCH] Kill unneeded linux/version.h include in net/ipv6
Content-Type: multipart/mixed;
 boundary="------------020308040205020607070106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020308040205020607070106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	Patch against 2.6-test4.

	Removes an unneeded linux/version.h include from af_inet6..

	Please consider applying.

	Cheers,

Felipe

--------------020308040205020607070106
Content-Type: text/plain;
 name="ipv6-checkversion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipv6-checkversion.patch"

--- linux-2.6.0-test4/net/ipv6/af_inet6.c	Fri Aug 22 20:56:34 2003
+++ linux-2.6.0-test4-fwd/net/ipv6/af_inet6.c	Wed Sep  3 10:58:48 2003
@@ -40,7 +40,6 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/init.h>
-#include <linux/version.h>
 
 #include <linux/inet.h>
 #include <linux/netdevice.h>

--------------020308040205020607070106--

