Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTFWAR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 20:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTFWAR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 20:17:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59596 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264469AbTFWARz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 20:17:55 -0400
Date: Mon, 23 Jun 2003 02:31:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.73: acorn.c compile error
Message-ID: <20030623003159.GF3710@fs.tum.de>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 11:53:14AM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.72 to v2.5.73
> ============================================
>...
> Russell King:
>...
>   o Update Acorn partition parsing
>...

There's the following compile error #ifdef CONFIG_ACORN_PARTITION_EESOX:

<--  snip  -->

...
  CC      fs/partitions/acorn.o
fs/partitions/acorn.c: In function `adfspart_check_EESOX':
fs/partitions/acorn.c:541: error: `first_sector' undeclared (first use 
in this function)
fs/partitions/acorn.c:541: error: (Each undeclared identifier is 
reported only once
fs/partitions/acorn.c:541: error: for each function it appears in.)
fs/partitions/acorn.c:550: error: `hd' undeclared (first use in this 
function)
fs/partitions/acorn.c:551: warning: implicit declaration of function 
`add_gd_partition'
fs/partitions/acorn.c:551: error: `minor' undeclared (first use in this 
function)
make[2]: *** [fs/partitions/acorn.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

