Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVHXOoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVHXOoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 10:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVHXOoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 10:44:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47364 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751029AbVHXOoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 10:44:12 -0400
Date: Wed, 24 Aug 2005 16:44:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
Message-ID: <20050824144411.GA4851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.13-rc6-mm2, but it seems to be 
a problem coming from Linus' tree introduced by the
  [ACPI] S3 resume: avoid kmalloc() might_sleep oops symptom
patch:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `acpi_os_allocate':
: undefined reference to `acpi_in_resume'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

