Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVBMAre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVBMAre (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 19:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVBMArd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 19:47:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19466 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261225AbVBMArc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 19:47:32 -0500
Date: Sun, 13 Feb 2005 01:47:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: 2.6: drivers/input/power.c is never built
Message-ID: <20050213004729.GA3256@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6, drivers/input/power.c would only have been built if 
CONFIG_INPUT_POWER was enabled - but it is nowhere possible to enable 
this option.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

