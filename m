Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTE2Uoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTE2Uoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:44:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41421 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262671AbTE2Uoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:44:32 -0400
Date: Thu, 29 May 2003 22:57:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: 2.5.70-mm2: NCR_D700.c doesn't compile
Message-ID: <20030529205742.GI5643@fs.tum.de>
References: <20030529012914.2c315dad.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529012914.2c315dad.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/scsi/NCR_D700.o
In file included from include/linux/mca.h:132,
                 from drivers/scsi/NCR_D700.c:99:
include/linux/mca-legacy.h:10:2: warning: #warning "MCA legacy - please 
move your driver to the new sysfs api"
drivers/scsi/NCR_D700.c: In function `NCR_D700_exit':
drivers/scsi/NCR_D700.c:388: too few arguments to function `scsi_sysfs_release_attributes'
make[2]: *** [drivers/scsi/NCR_D700.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

