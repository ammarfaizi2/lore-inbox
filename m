Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWGWTCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWGWTCl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 15:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWGWTCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 15:02:41 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10259 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751268AbWGWTCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 15:02:40 -0400
Date: Sun, 23 Jul 2006 21:02:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: RFC: remove include/mtd/jffs2-user.h
Message-ID: <20060723190239.GB25367@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/mtd/jffs2-user.h is not used in the kernel, and depends on 
user space providing a variable target_endian.

I don't see it providing an interface between the kernel and user space.

It seems this header should be part of the user space MTD tools instead 
of headers provided by the kernel?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

