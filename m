Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSFTHly>; Thu, 20 Jun 2002 03:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSFTHlx>; Thu, 20 Jun 2002 03:41:53 -0400
Received: from [194.85.255.177] ([194.85.255.177]:21888 "HELO blacklake.uucp")
	by vger.kernel.org with SMTP id <S293680AbSFTHlw>;
	Thu, 20 Jun 2002 03:41:52 -0400
Date: Thu, 20 Jun 2002 10:42:26 +0300
From: Dzmitry Chekmarou <diavolo@mail.ru>
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add missed include linux/tqueue.h to fs/smbfs/sock.c
Message-ID: <20020620074226.GA27616@blacklake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

here is fix:

diff -Nru a/fs/smbfs/sock.c b/fs/smbfs/sock.c
--- a/fs/smbfs/sock.c   Thu Jun 20 10:19:35 2002
+++ b/fs/smbfs/sock.c   Wed Jun 19 18:17:40 2002
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/smp_lock.h>
+#include <linux/tqueue.h>
 #include <net/scm.h>
 #include <net/ip.h>

wbr zmiter
