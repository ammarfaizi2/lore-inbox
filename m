Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272503AbTGaPG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272506AbTGaPG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:06:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19668 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272503AbTGaPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:06:55 -0400
Date: Thu, 31 Jul 2003 17:06:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm2: BTTV build error
Message-ID: <20030731150648.GG22991@fs.tum.de>
References: <20030730223810.613755b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730223810.613755b4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 10:38:10PM -0700, Andrew Morton wrote:
>...
> +bttv-driver-update.patch
> 
>  BTTV update
>...

<--  snip  -->

...
  CC      drivers/media/video/bttv-cards.o
drivers/media/video/bttv-cards.c: In function `pvr_boot':
drivers/media/video/bttv-cards.c:2549: error: incompatible types in 
initialization
drivers/media/video/bttv-cards.c:2552: warning: implicit declaration of 
function `request_firmware'
drivers/media/video/bttv-cards.c:2556: error: `rc' undeclared (first use 
in this function)
drivers/media/video/bttv-cards.c:2556: error: (Each undeclared 
identifier is reported only once
drivers/media/video/bttv-cards.c:2556: error: for each function it 
appears in.)
drivers/media/video/bttv-cards.c:2558: error: dereferencing pointer to 
incomplete type
drivers/media/video/bttv-cards.c:2558: error: dereferencing pointer to 
incomplete type
drivers/media/video/bttv-cards.c:2559: warning: implicit declaration of 
function `release_firmware'
make[3]: *** [drivers/media/video/bttv-cards.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

