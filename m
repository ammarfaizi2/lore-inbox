Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVBJX4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVBJX4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 18:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVBJX4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 18:56:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14343 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261933AbVBJX4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 18:56:09 -0500
Date: Fri, 11 Feb 2005 00:56:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Oberritter <obi@linuxtv.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: DVB at76c651.c driver seems to be dead code
Message-ID: <20050210235605.GN2958@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any way how the drivers/media/dvb/frontends/at76c651.c 
driver would do anything inside kernel 2.6.11-rc3-mm2. All it does is to 
EXPORT_SYMBOL a function at76c651_attach that isn't used anywhere.

Is a patch to remove this driver OK or did I miss anything?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

