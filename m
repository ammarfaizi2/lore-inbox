Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRGLNH2>; Thu, 12 Jul 2001 09:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbRGLNHS>; Thu, 12 Jul 2001 09:07:18 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:8897 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S262288AbRGLNHF>; Thu, 12 Jul 2001 09:07:05 -0400
Date: Thu, 12 Jul 2001 14:08:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Mark Thomson <MarkTT@excite.com>
cc: markhe@nextd.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1062!
In-Reply-To: <13568034.994942508879.JavaMail.imail@slippery>
Message-ID: <Pine.LNX.4.21.0107121405500.1568-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Mark Thomson wrote:
> 
> I have a Motorola SM56 PCI modem, and I got the following error when doing
> 'insmod sm56'.
> The sm56 module used to work for all 2.4 kernels prior to kernel 2.4.6. (It
> can be found at
> http://e-www.motorola.com/products/softmodem/support/software.html#linux)
> 
> Using /lib/modules/2.4.6/kernel/drivers/char/sm56.o
> kernel BUG at slab.c:1062!

Someone posted a similar problem (with another driver) earlier on:
you must recompile the module for 2.4.6, changes in the GFP_ mask
definitions mean the old module is incompatible with the new kernel.

Hugh

