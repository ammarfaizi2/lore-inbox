Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264676AbTFXSJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTFXSJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:09:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40145 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264676AbTFXSJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:09:05 -0400
Date: Tue, 24 Jun 2003 20:23:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.73 compile results
Message-ID: <20030624182307.GA3710@fs.tum.de>
References: <1056475577.9839.110.camel@cherrypit.pdx.osdl.net> <20030624173900.GV3710@fs.tum.de> <1056478596.9839.118.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056478596.9839.118.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 11:16:37AM -0700, John Cherry wrote:
> Unfortunately, the build continues even when it runs into compile or
> link errors.  So if a binary impacts multiple components in the build,
> it results in multiple errors.
> 
> The root of the nine errors is...
> 
> fs/partitions/acorn.c: In function `adfspart_check_EESOX':
> fs/partitions/acorn.c:541: `first_sector' undeclared (first use in this
> function)
> fs/partitions/acorn.c:541: (Each undeclared identifier is reported only
> once
> fs/partitions/acorn.c:541: for each function it appears in.)
> fs/partitions/acorn.c:550: `hd' undeclared (first use in this function)
> fs/partitions/acorn.c:551: warning: implicit declaration of function
> `add_gd_partition'
> fs/partitions/acorn.c:551: `minor' undeclared (first use in this
> function)
> make[2]: [fs/partitions/acorn.o] Error 1 (ignored)
> 
> Sorry for the confusion....but at least it got your attention!  :)

I was surprised about nine new errors just to find it's one error I 
already reported yesterday...

Could you change your scripts to avoid that such errors are counted that 
often?

> John

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

