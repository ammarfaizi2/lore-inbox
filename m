Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSDJPIw>; Wed, 10 Apr 2002 11:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313200AbSDJPHr>; Wed, 10 Apr 2002 11:07:47 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:23300 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313189AbSDJPG2>; Wed, 10 Apr 2002 11:06:28 -0400
Message-ID: <3CB453DC.7050902@namesys.com>
Date: Wed, 10 Apr 2002 19:01:48 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS bugfixes, please apply, 13 of 13
Content-Type: multipart/mixed;
 boundary="------------070601030504020108040209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601030504020108040209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070601030504020108040209
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 13 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 13 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13290 invoked from network); 10 Apr 2002 11:21:51 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:51 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 3AAF54D1B33; Wed, 10 Apr 2002 15:21:51 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:51 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 13 of 13
Message-ID: <20020410152151.A20921@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


  This patch fixes small typo in ikernel informational message.

--- linux-2.5.8-pre2/fs/reiserfs/super.c.orig	Mon Apr  8 14:23:15 2002
+++ linux-2.5.8-pre2/fs/reiserfs/super.c	Mon Apr  8 14:24:23 2002
@@ -769,7 +769,7 @@
     if ( rs->s_v1.s_root_block == -1 ) {
        brelse(bh) ;
        printk("dev %s: Unfinished reiserfsck --rebuild-tree run detected. Please run\n"
-              "reiserfsck --rebuild-tree and wait for a completion. If that fais\n"
+              "reiserfsck --rebuild-tree and wait for a completion. If that fails\n"
               "get newer reiserfsprogs package\n", s->s_id);
        return 1;
     }



--------------070601030504020108040209--

