Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTIOKpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTIOKpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:45:43 -0400
Received: from MAILGW02.bang-olufsen.dk ([193.89.221.125]:57614 "EHLO
	mailgw02.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id S261304AbTIOKpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:45:42 -0400
Message-ID: <3F659850.9000603@bitplanet.net>
Date: Mon, 15 Sep 2003 12:45:36 +0200
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Typo in scripts/postmod.c
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.11  |July
 24, 2002) at 15-09-2003 12:45:35,
	Serialize by Router on dzln13/Bang & Olufsen/DK(Release 6.0.2CF1|June 9, 2003) at
 15-09-2003 12:45:42,
	Serialize complete at 15-09-2003 12:45:42
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

There's a small typo in scripts/postmod.c, see patch below.

regards, Kristian

--- orig/linux-2.6.0-test5/scripts/modpost.c    2003-09-08
21:49:55.000000000 +0200
+++ linux-2.6.0-test5/scripts/modpost.c 2003-09-15 12:00:05.000000000 +0200
@@ -193,7 +193,7 @@


         *size = st.st_size;
         map = mmap(NULL, *size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
-       if (mmap == MAP_FAILED) {
+       if (map == MAP_FAILED) {
                 perror(filename);
                 abort();
         }


