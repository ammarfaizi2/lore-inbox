Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVCVTyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVCVTyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVCVTyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:54:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63754 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261761AbVCVTxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:53:39 -0500
Date: Tue, 22 Mar 2005 20:53:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/video/imsttfb.c: setclkMHz: clk_p is always 0
Message-ID: <20050322195338.GI1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noticed that in the function setclkMHz in 
drivers/video/imsttfb.c, the variable clk_p is never assigned a value 
other than 0.

Could someone understanding this code decide whether this is a real bug 
or whether clk_p can be replaced by 0?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

