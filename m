Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWAEWIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWAEWIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWAEWIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:08:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38917 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932249AbWAEWIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:08:07 -0500
Date: Thu, 5 Jan 2006 23:08:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: -mm1: drivers/char/amiserial.c doesn't compile
Message-ID: <20060105220805.GG12313@stusta.de>
References: <20060105062249.4bc94697.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105062249.4bc94697.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, your tty-layer-buffering-revamp.patch in -mm causes the following 
compile error on m68k:

<--  snip  -->

...
  CC      drivers/char/amiserial.o
drivers/char/amiserial.c: In function `receive_chars':
drivers/char/amiserial.c:321: error: label `ignore_char' used but not defined
make[2]: *** [drivers/char/amiserial.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

