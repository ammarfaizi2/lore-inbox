Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUHGRBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUHGRBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUHGRBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:01:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8185 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263725AbUHGRB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:01:29 -0400
Date: Sat, 7 Aug 2004 19:01:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org,
       schwidefsky@de.ibm.com
Cc: linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: architectures with their own "config PCMCIA"
Message-ID: <20040807170122.GM17708@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following architetures have their own "config PCMCIA" instead of 
including drivers/pcmcia/Kconfig (in 2.6.8-rc3-mm1):
- m68k
- s390
- sparc
- sparc64

Is there any good reason for this, or would a patch to change these 
architectures to include drivers/pcmcia/Kconfig be OK?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

