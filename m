Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbTGCKEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbTGCKEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:04:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46052 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265889AbTGCKEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:04:33 -0400
Date: Thu, 3 Jul 2003 12:18:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: 2.5.74: aha1740.c doesn't compile
Message-ID: <20030703101846.GH282@fs.tum.de>
References: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/aha1740.c fails to build on 2.5.74 withthe following error:

<--  snip  -->

...
  CC      drivers/scsi/aha1740.o
drivers/scsi/aha1740.c: In function `aha1740_queuecommand':
drivers/scsi/aha1740.c:378: error: request for member `magic' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `lock' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `babble' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `babble' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `module' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `owner' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `oline' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `lock' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `owner' in 
something not a structure or union
drivers/scsi/aha1740.c:378: error: request for member `oline' in 
something not a structure or union
drivers/scsi/aha1740.c:397: error: request for member `magic' in 
something not a structure or union
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

