Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbTGBI0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264825AbTGBI0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:26:55 -0400
Received: from a089197.adsl.hansenet.de ([213.191.89.197]:12976 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S264832AbTGBI0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:26:54 -0400
Message-ID: <3F029AAA.7090807@tu-harburg.de>
Date: Wed, 02 Jul 2003 10:41:14 +0200
From: Jan Dittmer <jan.dittmer@tu-harburg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] include pci.h in sbp2.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

new bug in -mm3.
include pci.h in sbp2.c to fix compilation.

Thanks,

Jan

--- linux-mm/drivers/ieee1394/sbp2.c	Wed Jul  2 07:57:13 2003
+++ 2.5.73-mm3/drivers/ieee1394/sbp2.c	Wed Jul  2 09:14:23 2003
@@ -56,6 +56,7 @@
  #include <linux/smp_lock.h>
  #include <linux/init.h>
  #include <linux/version.h>
+#include <linux/pci.h>
  #include <asm/current.h>
  #include <asm/uaccess.h>
  #include <asm/io.h>

