Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVA3JeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVA3JeT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 04:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVA3JeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 04:34:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52240 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261661AbVA3JeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 04:34:15 -0500
Date: Sun, 30 Jan 2005 10:34:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: reiser4 cryptcompress.c: X<Y<=Z comparison
Message-ID: <20050130093413.GD3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 4.0 gives the following warning:

<--  snip  -->

...
  CC      fs/reiser4/plugin/cryptcompress.o
fs/reiser4/plugin/cryptcompress.c: In function 'grab_cluster_pages':
fs/reiser4/plugin/cryptcompress.c:1415: warning: comparisons like X<=Y<=Z do  have their mathematical meaning
...

<--  snip  -->

After a quick look, it seems gcc is correct and this assertion needs a
correction.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

