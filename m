Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262880AbRE0Xyv>; Sun, 27 May 2001 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbRE0Xym>; Sun, 27 May 2001 19:54:42 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24533 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262880AbRE0Xy2>;
	Sun, 27 May 2001 19:54:28 -0400
Message-ID: <3B1193A8.6DB90579@mandrakesoft.com>
Date: Sun, 27 May 2001 19:54:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
Cc: "Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: 2.4.5 does not link on Ruffian (alpha)
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <3B102822.625E01DF@mandrakesoft.com> <3B1032BE.72BD1336@mandrakesoft.com> <20010527163901.A18929@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> On Sat, May 26, 2001 at 06:48:30PM -0400, Jeff Garzik wrote:
> > When built with CONFIG_ALPHA_NAUTILUS, my UP1000's IDE totally fails.
> 
> Mine doesn't.
> 
> > I am booting w/ aboot 0.7a from SRM, -without- the
> > srm-as-bootloader kernel config option.
> 
> That is the error.

Ok, thanks.

FWIW the documentation seems to imply that the option is necessary only
when directly booting from SRM, i.e.. no bootloader is involved at all. 
It uses the example of MILO's presence or absence as indicating the need
for this option.

So... is it safe to always enable this option, with a little hacking
perhaps?  :)   

Regards,

	Jeff





> Using SRM as bootloader
> CONFIG_ALPHA_SRM
>   There are two different types of booting firmware on Alphas: SRM,
>   which is command line driven, and ARC, which uses menus and arrow
>   keys. Details about the Linux/Alpha booting process are contained in
>   the Linux/Alpha FAQ, accessible on the WWW from
>   http://www.alphalinux.org .
> 
>   The usual way to load Linux on an Alpha machine is to use MILO
>   (a bootloader that lets you pass command line parameters to the
>   kernel just like lilo does for the x86 architecture) which can be
>   loaded either from ARC or can be installed directly as a permanent
>   firmware replacement from floppy (which requires changing a certain
>   jumper on the motherboard). If you want to do either of these, say N
>   here. If MILO doesn't work on your system (true for Jensen
>   motherboards), you can bypass it altogether and boot Linux directly
>   from an SRM console; say Y here in order to do that. Note that you
>   won't be able to boot from an IDE disk using SRM. 
> 
>   If unsure, say N.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
