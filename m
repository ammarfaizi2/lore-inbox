Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCAClW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCAClW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 21:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVCAClW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 21:41:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19212 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261204AbVCAClU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 21:41:20 -0500
Date: Tue, 1 Mar 2005 03:41:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RFC: disallow modular framebuffers
Message-ID: <20050301024118.GF4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and 
FB_SAVAGE_ACCEL=m are currently broken) I asked myself:

Do modular framebuffers really make sense?

OK, distributions like to make everything modular, but all the 
framebuffer drivers I've looked at parse driver specific options in 
their *_setup function only in the non-modular case.

And most framebuffer drivers contain a module_exit function.
Is there really any case where this is both reasonable and working?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

