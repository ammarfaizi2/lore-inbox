Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSDJO7R>; Wed, 10 Apr 2002 10:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313187AbSDJO7Q>; Wed, 10 Apr 2002 10:59:16 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:4112 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S313184AbSDJO7O>;
	Wed, 10 Apr 2002 10:59:14 -0400
Message-ID: <3CB4522B.6030600@namesys.com>
Date: Wed, 10 Apr 2002 18:54:35 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS bugfixes 8 of 13, please apply
Content-Type: multipart/mixed;
 boundary="------------060807030106040004040305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060807030106040004040305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060807030106040004040305
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 8 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 8 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13265 invoked from network); 10 Apr 2002 11:21:51 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:51 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 022924D1B34; Wed, 10 Apr 2002 15:21:51 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 8 of 13
Message-ID: <20020410152150.A20896@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch renames reiserfs debugging option in config output,
to make its meaning more clear.


--- linux-2.5.8-pre2/fs/Config.in.orig	Thu Mar 21 12:50:18 2002
+++ linux-2.5.8-pre2/fs/Config.in	Thu Mar 21 12:50:58 2002
@@ -9,7 +9,7 @@
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
 
 tristate 'Reiserfs support' CONFIG_REISERFS_FS
-dep_mbool '  Have reiserfs do extra internal checking' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
+dep_mbool '  Enable reiserfs debug mode' CONFIG_REISERFS_CHECK $CONFIG_REISERFS_FS
 dep_mbool '  Stats in /proc/fs/reiserfs' CONFIG_REISERFS_PROC_INFO $CONFIG_REISERFS_FS
 
 dep_tristate 'ADFS file system support' CONFIG_ADFS_FS $CONFIG_EXPERIMENTAL



--------------060807030106040004040305--

