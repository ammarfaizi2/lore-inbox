Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTE2WCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTE2WCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:02:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6604 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262883AbTE2WCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:02:16 -0400
Date: Fri, 30 May 2003 00:15:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: 2.5.70-mm2: g_NCR5380 link errors
Message-ID: <20030529221526.GL5643@fs.tum.de>
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
drivers/scsi/g_NCR5380_mmio.o(.text+0x5a0): In function 
`notyet_generic_proc_info':
: multiple definition of `notyet_generic_proc_info'
drivers/scsi/g_NCR5380.o(.text+0x5a0): first defined here
drivers/scsi/g_NCR5380_mmio.o(.text+0x2d20): In function 
`generic_NCR5380_proc_info':
: multiple definition of `generic_NCR5380_proc_info'
drivers/scsi/g_NCR5380.o(.text+0x2d20): first defined here
make[2]: *** [drivers/scsi/built-in.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

