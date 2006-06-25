Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWFYUvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWFYUvk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWFYUvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:51:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2834 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932325AbWFYUvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:51:39 -0400
Date: Sun, 25 Jun 2006 22:51:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: -git: Why is drivers/net/wan/hdlc_generic.c:hdlc_setup() exported?
Message-ID: <20060625205137.GH23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4a31e348e3ecaf54c50240109ac4574b180f8840 added an 
EXPORT_SYMBOL(hdlc_setup) with the justification
   hdlc_setup() is now EXPORTed as per David's request.

Is a usage of this export pending for the near future or could this 
export be reverted until a user is submitted for inclusion?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

