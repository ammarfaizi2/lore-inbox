Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTE2VHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTE2VHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:07:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50124 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262827AbTE2VEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:04:46 -0400
Date: Thu, 29 May 2003 23:17:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: 2.5.70-mm2: NCR53C9x.c doesn't compile
Message-ID: <20030529211757.GJ5643@fs.tum.de>
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
  CC      drivers/scsi/NCR53C9x.o
drivers/scsi/NCR53C9x.c: In function `esp_proc_info':
drivers/scsi/NCR53C9x.c:896: `SCpnt' undeclared (first use in this function)
drivers/scsi/NCR53C9x.c:896: (Each undeclared identifier is reported only once
drivers/scsi/NCR53C9x.c:896: for each function it appears in.)
drivers/scsi/NCR53C9x.c: In function `esp_do_data':
drivers/scsi/NCR53C9x.c:1840: warning: unused variable `flags'
make[2]: *** [drivers/scsi/NCR53C9x.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

