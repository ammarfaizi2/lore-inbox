Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUGTRZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUGTRZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUGTRZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:25:16 -0400
Received: from [213.146.154.40] ([213.146.154.40]:4047 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265962AbUGTRZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:25:09 -0400
Subject: Re: [PATCH][2.6.8-rc2] Fix JFFS2_COMPRESSION_OPTIONS in Kconfig
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org, akpm@osdl.org, kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040719154145.GA5429@dreamland.darkstar.lan>
References: <20040719154145.GA5429@dreamland.darkstar.lan>
Content-Type: text/plain
Date: Tue, 20 Jul 2004 13:24:59 -0400
Message-Id: <1090344299.4189.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-19 at 17:41 +0200, Kronos wrote:
> Hi,
> It seems to me that JFFS2_COMPRESSION_OPTIONS depends on JFFS2_FS:

Indeed it does.

Linus/Andrew, please pull from bk://linux-mtd.bkbits.net/mtd-2.6. 

It has Kronos' fix and a couple more from Adrian Bunk, and it also marks
the JFFS2 support for NAND flash as no longer being experimental.

ChangeSet@1.1852, 2004-07-20 12:42:36-04:00, dwmw2@shinybook.infradead.org +1 -0
  NAND support in JFFS2 isn't experimental any more.
 
ChangeSet@1.1851, 2004-07-20 12:40:06-04:00, kronos@kronoz.cjb.net +1 -0
  Fix JFFS2_COMPRESSION_OPTIONS in Kconfig
   
  Hi,
  It seems to me that JFFS2_COMPRESSION_OPTIONS depends on JFFS2_FS:
   
  Signed-off-by: David Woodhouse <dwmw2@infradead.org>
 
ChangeSet@1.1850, 2004-07-20 12:37:20-04:00, bunk@fs.tum.de +1 -0
  MAINTAINERS: update MTD list
   
  Trying to send an email to mtd@infradead.org gives you the answer that
  you should use linux-mtd@lists.infradead.org instead.
   
  So let's update the entry in MAINTAINERS.
   
  Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
  Signed-off-by: David Woodhouse <dwmw2@infradead.org>
 
ChangeSet@1.1849, 2004-07-20 12:35:52-04:00, bunk@fs.tum.de +5 -0
  MTD: remove some kernel 2.0 and 2.2 #ifdef's
   
  The patch below (applies against 2.6.8-rc2) removes some #ifdef's for
  kernel 2.0 and 2.2 from the MTD code.
   
  Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
  Signed-off-by: David Woodhouse <dwmw2@infradead.org>
 


-- 
dwmw2

