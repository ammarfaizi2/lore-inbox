Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUGEWwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUGEWwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 18:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUGEWwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 18:52:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57575 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261867AbUGEWwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 18:52:45 -0400
Date: Tue, 6 Jul 2004 00:52:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: 2.6.7-mm6: ALSA: vortex_asXtalkGainsAllChan multiple definitions
Message-ID: <20040705225236.GI28324@fs.tum.de>
References: <20040705023120.34f7772b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.7-mm5:
>...
>  bk-alsa.patch
>...

<--  snip  -->

...
  CC      sound/pci/au88x0/au8810.o
  CC      sound/pci/au88x0/au8820.o
  CC      sound/pci/au88x0/au8830.o
  LD      sound/pci/au88x0/snd-au8810.o
  LD      sound/pci/au88x0/snd-au8820.o
  LD      sound/pci/au88x0/snd-au8830.o
  LD      sound/pci/au88x0/built-in.o
sound/pci/au88x0/snd-au8830.o(.rodata+0xd46): multiple definition of `vortex_asXtalkGainsAllChan'
sound/pci/au88x0/snd-au8810.o(.rodata+0xb66): first defined here
make[3]: *** [sound/pci/au88x0/built-in.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

