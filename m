Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136512AbREIOv7>; Wed, 9 May 2001 10:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136518AbREIOvu>; Wed, 9 May 2001 10:51:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28428 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136512AbREIOvf>;
	Wed, 9 May 2001 10:51:35 -0400
Date: Wed, 9 May 2001 16:51:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Giacomo Mulas <gmulas@ca.astro.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.4: BUG in ll_rw_blk.c?
Message-ID: <20010509165125.C521@suse.de>
In-Reply-To: <Pine.LNX.4.21.0105091634370.29725-100000@capitanata.ca.astro.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105091634370.29725-100000@capitanata.ca.astro.it>; from gmulas@ca.astro.it on Wed, May 09, 2001 at 04:45:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09 2001, Giacomo Mulas wrote:
> 	I am running a 2.4.4 kernel compiled from the sources in the
> debian kernel-source package (it only includes a couple of small patches
> taken from pre and ac, as far as I can tell) and run in the following
> oopses, always while compiling the kernel itself. Here I included three
> different oopses, and the computer had been rebooted between them (for
> different reasons). Is this a known bug? Any fix available for it?
> The computer is a 500MHz PIII, with a 440BX chipset on the motherboard,
> more data available if required (just ask) running debian potato. The only
> "nonstandard" system component is a 2.1.3 libc6 compiled with the 2.4.4
> kernel headers, to be able to use large files. Here come the
> (decoded) oopses:
> 
> May  7 14:57:11 stampace kernel: elevator returned crap (-1072325408)
> May  7 14:57:11 stampace kernel: kernel BUG at ll_rw_blk.c:778!
> May  7 14:57:11 stampace kernel: invalid operand: 0000

If this happens, either your kernel or hardware is seriously screwed --
this is a _never happens_ case. So I suggest that you try a pristine
kernel, most likely this one has been mangled.

-- 
Jens Axboe

