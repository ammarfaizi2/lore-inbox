Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWDGM2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWDGM2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 08:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWDGM2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 08:28:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38411 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964784AbWDGM17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 08:27:59 -0400
Date: Fri, 7 Apr 2006 14:27:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: 2.6.17-rc1-mm1: drivers/acpi/numa.c compile error
Message-ID: <20060407122757.GI7118@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error with CONFIG_ACPI_NUMA=y:

<--  snip  -->

...
  CC      drivers/acpi/numa.o
drivers/acpi/numa.c: In function 'acpi_numa_init':
drivers/acpi/numa.c:231: error: 'NR_NODE_MEMBLKS' undeclared (first use in this function)
drivers/acpi/numa.c:231: error: (Each undeclared identifier is reported only once
drivers/acpi/numa.c:231: error: for each function it appears in.)
make[2]: *** [drivers/acpi/numa.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

