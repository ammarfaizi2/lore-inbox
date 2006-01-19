Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWASASy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWASASy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWASASy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:18:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29705 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161084AbWASASx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:18:53 -0500
Date: Thu, 19 Jan 2006 01:18:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sam@ravnborg.org
Cc: starvik@axis.com, dev-etrax@axis.com, linux-kernel@vger.kernel.org
Subject: cris: asm-offsets related build failure
Message-ID: <20060119001852.GO19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

the following build failure is present on the cris architecture:

<--  snip  -->

...
make[1]: *** No rule to make target `arch/cris/kernel/asm-offsets.c', 
needed by `arch/cris/kernel/asm-offsets.s'.  Stop.
make: *** [prepare0] Error 2

<--  snip  -->


The problem seems to be that the cris port has two different files for 
this purpose:
arch/cris/arch-v10/kernel/asm-offsets.c
arch/cris/arch-v32/kernel/asm-offsets.c


What is the best way to handle this?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

