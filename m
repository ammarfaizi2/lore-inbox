Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276305AbRJUPjI>; Sun, 21 Oct 2001 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJUPiu>; Sun, 21 Oct 2001 11:38:50 -0400
Received: from deepthought.blinkenlights.nl ([62.58.162.228]:2820 "EHLO
	mail.blinkenlights.nl") by vger.kernel.org with ESMTP
	id <S276309AbRJUPil>; Sun, 21 Oct 2001 11:38:41 -0400
Date: Sun, 21 Oct 2001 17:52:34 +0200 (CEST)
From: Sten <sten@blinkenlights.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
In-Reply-To: <20011021.080432.71105870.davem@redhat.com>
Message-ID: <Pine.LNX.4.40-blink.0110211736030.19859-100000@deepthought.blinkenlights.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2001, David S. Miller wrote:

>
> Don't use AC kernels, I do not keep track of them and therefore
> Sparc64 builds are likely to not work.
>
> Use Linus's kernels, I keep him uptodate with all the latest
> changes and I make sure his releases compile on sparc64.

ahah, I had quite a few problems getting framebuffer, dri
and all to work on each kernel that I overlooked that.

With the linux 2.4.12 I cant seem to get dri to compile
for instance.

drivers/char/drm/drm.o: In function `ffb_vm_shm_nopage':
drivers/char/drm/drm.o(.text+0x4ba8): undefined reference to
`virt_to_bus_not_defined_use_pci_map'
drivers/char/drm/drm.o: In function `ffb_vm_dma_nopage':
drivers/char/drm/drm.o(.text+0x4e4c): undefined reference to
`virt_to_bus_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

The main annoiance is the 3.5mb size limitation
which one reaches quite quickly.

ow well, I am gonna trow a some time at the 3ware driver
to see how long it'll take before I give up trying to get
it to work on sparc64 ;).


So long and give the penguin some fish.

--
Sten Spans

