Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTBEXGw>; Wed, 5 Feb 2003 18:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTBEXGw>; Wed, 5 Feb 2003 18:06:52 -0500
Received: from [195.223.140.107] ([195.223.140.107]:50304 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265154AbTBEXGv>;
	Wed, 5 Feb 2003 18:06:51 -0500
Date: Thu, 6 Feb 2003 00:16:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre4aa1
Message-ID: <20030205231627.GS19678@dualathlon.random>
References: <20030131014020.GA8395@dualathlon.random> <3E419A43.7070100@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E419A43.7070100@rackable.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 03:12:03PM -0800, Samuel Flory wrote:
> Is the dac960 compile still broken?  Or did it break again?
> 
> make[3]: Entering directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
> gcc -D__KERNEL__ -I/stuff/src/linux-2.4.21-pre4-aa1/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=DAC960  -DEXPORT_SYMTAB 
> -c DAC960.c
> DAC960.c: In function `DAC960_ProcessCompletedBuffer':
> DAC960.c:3029: warning: passing arg 1 of `blk_finished_io' makes pointer 
> from integer without a cast
> DAC960.c:3029: too few arguments to function `blk_finished_io'
> make[3]: *** [DAC960.o] Error 1
> make[3]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers/block'
> make[1]: *** [_subdir_block] Error 2
> make[1]: Leaving directory `/stuff/src/linux-2.4.21-pre4-aa1/drivers'
> make: *** [_dir_drivers] Error 2

It was supposed to be fixed I need to re-check.. (I usually don't
compile it so I didn't notice sorry)

Andrea
