Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSLTOkL>; Fri, 20 Dec 2002 09:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSLTOkL>; Fri, 20 Dec 2002 09:40:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55242 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262289AbSLTOkK>; Fri, 20 Dec 2002 09:40:10 -0500
Date: Fri, 20 Dec 2002 15:48:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Ben Collins <bcollins@debian.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux1394-devel@lists.sourceforge.net
Subject: Re: Linux 2.4.21-pre2
Message-ID: <20021220144808.GF27658@fs.tum.de>
References: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 05:22:50PM -0200, Marcelo Tosatti wrote:

>...
> Summary of changes from v2.4.21-pre1 to v2.4.21-pre2
> ============================================
>...
> Ben Collins <bcollins@debian.org>:
>   o Linux1394 Firewire
>...

The changes to drivers/ieee1394/Makefile broke the compilation at least 
when compiling the ieee1394 code statically into the kernel:

1. Nothing gets built in drivers/ieee1394.

2. The final linking fails with the following error:

<--  snip  -->

...
        -o vmlinux
ld: cannot open drivers/ieee1394/ieee1394drv.o: No such file or directory
make: *** [vmlinux] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

