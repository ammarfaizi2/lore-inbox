Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbTIGJm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 05:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTIGJm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 05:42:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32976 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263297AbTIGJmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 05:42:24 -0400
Date: Sun, 7 Sep 2003 11:42:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: chimicus <chimicus75@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compilation error in 2.4.23-pre3
Message-ID: <20030907094200.GL14436@fs.tum.de>
References: <200309070206.10477.chimicus75@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309070206.10477.chimicus75@libero.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 02:05:57AM +0200, chimicus wrote:
> 
> Hi, 

Hi,

> i failed compiling 2.4.23-pre3 because of this error:
> ...
> In file included from via82cxxx.c:39:
> ../ide-timing.h: In function `ide_find_best_mode':
> ../ide-timing.h:124: `XFER_UDMA_133' undeclared (first use in this function)
> ../ide-timing.h:124: (Each undeclared identifier is reported only once
> ../ide-timing.h:124: for each function it appears in.)
> via82cxxx.c: In function `via_get_info':
> via82cxxx.c:250: duplicate case value
> via82cxxx.c:246: previously used here
> via82cxxx.c: In function `via82cxxx_ide_dma_check':
> via82cxxx.c:407: `XFER_UDMA_133' undeclared (first use in this function)
>...

this doesn't seem to be a plain 2.4.23-pre3, in 2.4.23-pre3 ide-timing.h 
XFER_UDMA_133 is #define'd and line 124 is completely empty.

Which modifications did you make in your kernel sources?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

