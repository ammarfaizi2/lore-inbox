Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268811AbTGTWSD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268794AbTGTWSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:18:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51186 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268848AbTGTWRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:17:31 -0400
Date: Mon, 21 Jul 2003 00:32:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [linuxdc-dev] Problem trying to build 2.6.0-test1
Message-ID: <20030720223224.GJ26422@fs.tum.de>
References: <200307201500.46604.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307201500.46604.adrian@mcmen.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 03:00:46PM +0100, Adrian McMenamin wrote:
> This is a message I posted to the Dreamcast linux development list. It appears 
> to be a problem with the cross assembler (target is SH4, host is ia32) I am 
> using but before I put it down to that, I wonder if anybody else has seen 
> this and can offer a comment?
> 
> It is certainly not a configuration problem as the SH4 maintainer has built 
> this kernel for the Dreamcast (he's probably the only one apart from me to 
> have even tried :() and when I used his .config it failed in just the same 
> way.
>...
>   AS      usr/initramfs_data.o
> usr/initramfs_data.S: Assembler messages:
> usr/initramfs_data.S:2: Error: Unknown pseudo-op:  `.incbin'
> make[2]: *** [usr/initramfs_data.o] Error 1
> make[1]: *** [usr] Error 2
> make: *** [vmlinux] Error 2

You need more recent binutils.

Documentation/Changes lists 2.12 as the minimum required version.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

