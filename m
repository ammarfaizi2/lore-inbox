Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVE2Oii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVE2Oii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 10:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVE2Oii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 10:38:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29705 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261329AbVE2Oi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 10:38:28 -0400
Date: Sun, 29 May 2005 16:38:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Patrick Caulfield <pcaulfie@redhat.com>
Subject: 2.6.12-rc5-mm1: drivers/dlm/: compile error with gcc 2.95
Message-ID: <20050529143818.GB10441@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  CC      drivers/dlm/lock.o
drivers/dlm/lock.c: In function `receive_grant':
drivers/dlm/lock.c:2658: parse error before `;'
drivers/dlm/lock.c: In function `receive_bast':
drivers/dlm/lock.c:2685: parse error before `;'
drivers/dlm/lock.c: In function `receive_request_reply':
drivers/dlm/lock.c:2757: parse error before `;'
drivers/dlm/lock.c:2765: parse error before `;'
drivers/dlm/lock.c: In function `receive_convert_reply':
drivers/dlm/lock.c:2883: parse error before `;'
drivers/dlm/lock.c:2890: parse error before `;'
drivers/dlm/lock.c: In function `receive_unlock_reply':
drivers/dlm/lock.c:2930: parse error before `;'
drivers/dlm/lock.c:2937: parse error before `;'
drivers/dlm/lock.c: In function `receive_cancel_reply':
drivers/dlm/lock.c:2977: parse error before `;'
drivers/dlm/lock.c:2984: parse error before `;'
drivers/dlm/lock.c: In function `receive_lookup_reply':
drivers/dlm/lock.c:3001: parse error before `;'
drivers/dlm/lock.c:3007: parse error before `;'
drivers/dlm/lock.c: In function `purge_queue':
drivers/dlm/lock.c:3325: parse error before `;'
make[2]: *** [drivers/dlm/lock.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

