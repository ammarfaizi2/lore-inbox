Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSFDQ0X>; Tue, 4 Jun 2002 12:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315091AbSFDQ0W>; Tue, 4 Jun 2002 12:26:22 -0400
Received: from mail1.zeelandnet.nl ([212.115.192.151]:32459 "EHLO
	mail.zeelandnet.nl") by vger.kernel.org with ESMTP
	id <S315042AbSFDQ0B>; Tue, 4 Jun 2002 12:26:01 -0400
Message-ID: <3CFC5E5D.9030406@zeelandnet.nl>
Date: Tue, 04 Jun 2002 05:29:49 -0100
From: ms <ms@zeelandnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.19-pre8 i686; en-US; rv:0.9.1) Gecko/20010610
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sisfb fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains a fix for recently submitted sisfb code from alan (ac).
Missing var in struct.

diff -Naur linux/include/linux/sisfb.h linux-sisfb/include/linux/sisfb.h
--- linux/include/linux/sisfb.h Tue Jun  4 18:22:32 2002
+++ linux-sisfb/include/linux/sisfb.h   Tue Jun  4 18:21:32 2002
@@ -108,6 +108,7 @@
        unsigned char revision_id;
 
        char reserved[256];
+       unsigned int mtrr;
 };
 
 #ifdef __KERNEL__



