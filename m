Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVCLNSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVCLNSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 08:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVCLNSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 08:18:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43275 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261907AbVCLNSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 08:18:15 -0500
Date: Sat, 12 Mar 2005 14:18:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-mm3: saa7134-core.c compile error
Message-ID: <20050312131813.GA3814@stusta.de>
References: <20050312034222.12a264c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 03:42:22AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-mm2:
>...
> +saa7134-update.patch
>...
>  v4l updates
>...

This doesn't compile with CONFIG_MODULES=n:

<--  snip  -->

...
  CC      drivers/media/video/saa7134/saa7134-core.o
drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_fini':
drivers/media/video/saa7134/saa7134-core.c:1215: error: `pending_registered' undeclared (first use in this function)
drivers/media/video/saa7134/saa7134-core.c:1215: error: (Each undeclared identifier is reported only once
drivers/media/video/saa7134/saa7134-core.c:1215: error: for each function it appears in.)
drivers/media/video/saa7134/saa7134-core.c:1216: error: `pending_notifier' undeclared (first use in this function)
make[4]: *** [drivers/media/video/saa7134/saa7134-core.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

