Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTI3Vcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTI3Vcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:32:35 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:54850 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261752AbTI3VcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:32:08 -0400
Message-ID: <3F79F795.5060505@wanadoo.fr>
Date: Tue, 30 Sep 2003 23:37:25 +0200
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Trivial 2.6.0-test6] Remove duplicated declarations in include/asm-i386/mman.h
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

--- bk/include/asm-i386/mman.h.orig     2003-09-30 23:33:07.000000000 +0200
+++ bk/include/asm-i386/mman.h  2003-09-30 23:33:16.000000000 +0200
@@ -8,8 +8,6 @@
 #define PROT_NONE      0x0             /* page can not be accessed */
 #define PROT_GROWSDOWN 0x01000000      /* mprotect flag: extend change 
to start of growsdown vma */
 #define PROT_GROWSUP   0x02000000      /* mprotect flag: extend change 
to end of growsup vma */
-#define PROT_GROWSDOWN 0x01000000      /* mprotect flag: extend change 
to start of growsdown vma */
-#define PROT_GROWSUP   0x02000000      /* mprotect flag: extend change 
to end of growsup vma */

 #define MAP_SHARED     0x01            /* Share changes */
 #define MAP_PRIVATE    0x02            /* Changes are private */

Regards,
Remi


