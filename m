Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310234AbSCALIe>; Fri, 1 Mar 2002 06:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSCALGd>; Fri, 1 Mar 2002 06:06:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11536 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310427AbSCALFD>;
	Fri, 1 Mar 2002 06:05:03 -0500
Date: Fri, 1 Mar 2002 12:04:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre2
Message-ID: <20020301110438.GE10178@suse.de>
In-Reply-To: <Pine.LNX.4.21.0202281742250.2182-100000@freak.distro.conectiva> <3C7EBAEC.B274829C@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7EBAEC.B274829C@eyal.emu.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01 2002, Eyal Lebedinsky wrote:
> Marcelo Tosatti wrote:
> > Here is 2.4.19-pre2: A very big patch (around 13MB uncompressed) due to
> 
> Practically everything module is built.
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
> -DKBUILD_BASENAME=cciss  -c -o cciss.o cciss.c
> cciss.c: In function `cciss_remove_one':
> cciss.c:2129: too few arguments to function `sendcmd'
> make[2]: *** [cciss.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/block'

A few cciss updates are still pending, so these will disappear for the
next -pre.

-- 
Jens Axboe

