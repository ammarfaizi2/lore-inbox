Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVHUWxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVHUWxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVHUWxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 18:53:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20487 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750702AbVHUWxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 18:53:16 -0400
Date: Mon, 22 Aug 2005 00:53:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: strange CRASH_DUMP dependencies
Message-ID: <20050821225310.GE5726@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

config CRASH_DUMP
	bool "kernel crash dumps (EXPERIMENTAL)"
	depends on EMBEDDED
	depends on EXPERIMENTAL
	depends on HIGHMEM
	help
	  Generate crash dump after being started by kexec.

Two questions:
- If it has any dependencies on kexec, why isn't there a dependency?
- Is there any sane reason for the dependency on EMBEDDED?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

