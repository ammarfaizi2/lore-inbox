Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbUAITbm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUAITbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:31:42 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6368 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263518AbUAITbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:31:40 -0500
Date: Fri, 9 Jan 2004 20:31:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz, Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: 2.6.1-mm1: sound/pci/cmipci.c compile error
Message-ID: <20040109193132.GK1440@fs.tum.de>
References: <20040109014003.3d925e54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109014003.3d925e54.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 01:40:03AM -0800, Andrew Morton wrote:
>...
> - A big ALSA update.
>...
> Changes since 2.6.1-rc2-mm1:
>...
> +alsa-101.patch
> 
>  ALSA update
>...

I got the following compile error when trying to compile 
sound/pci/cmipci.c statically into the kernel:

<--  snip  -->

...
  CC      sound/pci/cmipci.o
sound/pci/cmipci.c: In function `alsa_card_cmipci_setup':
sound/pci/cmipci.c:3300: error: `joystick' undeclared (first use in this function)
sound/pci/cmipci.c:3300: error: (Each undeclared identifier is reported only once
sound/pci/cmipci.c:3300: error: for each function it appears in.)
make[2]: *** [sound/pci/cmipci.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


