Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272968AbRIHGrI>; Sat, 8 Sep 2001 02:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272969AbRIHGqs>; Sat, 8 Sep 2001 02:46:48 -0400
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:7890 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272968AbRIHGqk>; Sat, 8 Sep 2001 02:46:40 -0400
From: Josh McKinney <forming@home.com>
Date: Sat, 8 Sep 2001 01:46:43 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre5
Message-ID: <20010908014643.A846@home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <3B99A8C2.56E88CE3@isn.net> <003001c1382d$f483d9d0$010da8c0@uglypunk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003001c1382d$f483d9d0$010da8c0@uglypunk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Sat, Sep 08, 2001 at 03:44:31PM +0930, Kingsley Foreman wrote:
> Yes i got this too
> anyone got a fix
Don't use gcc-3.0
> 
> 
> ----- Original Message -----
> From: "Garst R. Reese" <reese@isn.net>
> To: "linux-kernel" <linux-kernel@vger.kernel.org>
> Cc: <torvalds@transmeta.com>
> Sent: Saturday, September 08, 2001 2:42 PM
> Subject: 2.4.10-pre5
> 
> 
> > gcc-3.0
> > log should be self explanatory.
> > cc me if rqd.
> > Garst
> 
> 
> ----------------------------------------------------------------------------
> ----
> 
> 
> > make[2]: Entering directory `/usr/src/linux/drivers/block'
> >
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
> graphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpre
> ferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
> > rd.c: In function `rd_ioctl':
> > rd.c:262: invalid type argument of `->'
> > rd.c: In function `rd_cleanup':
> > rd.c:375: too few arguments to function `blkdev_put'
> > make[2]: *** [rd.o] Error 1
> > make[2]: Leaving directory `/usr/src/linux/drivers/block'
> > make[1]: *** [_modsubdir_block] Error 2
> > make[1]: Leaving directory `/usr/src/linux/drivers'
> > make: *** [_mod_drivers] Error 2
> > Command exited with non-zero status 2
> > 4.13user 0.37system 0:04.50elapsed 99%CPU (0avgtext+0avgdata
> 0maxresident)k
> > 0inputs+0outputs (3849major+4162minor)pagefaults 0swaps
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Linux, the choice          | Stupidity is its own reward. 
of a GNU generation   -o)  | 
Kernel 2.4.9-ac1       /\  | 
on a i586             _\_v | 
                           | 
