Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314439AbSEBN4G>; Thu, 2 May 2002 09:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314442AbSEBN4F>; Thu, 2 May 2002 09:56:05 -0400
Received: from [203.200.95.130] ([203.200.95.130]:5269 "EHLO mail.iitk.ac.in")
	by vger.kernel.org with ESMTP id <S314439AbSEBN4D>;
	Thu, 2 May 2002 09:56:03 -0400
Date: Thu, 2 May 2002 19:17:36 +0530 (IST)
From: SANDEEP DEY <sandey@iitk.ac.in>
To: sandeep dey <sandey@iitk.ac.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD PowerNow booboo in 2.4.19-pre7-ac3
In-Reply-To: <20020502101723.B23709@flint.arm.linux.org.uk>
Message-ID: <Pine.GH9.4.10.10205021917020.23209-100000@apah>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



SANDEEP DEY,
ROOM NO.308,
HALL 3,
IIT KANPUR,
KANPUR 208016.


"I am a slow walker but i do not walk backwards."
					Abraham Lincoln....
































On Thu, 2 May 2002, Russell King wrote:

> On Thu, May 02, 2002 at 06:51:37PM +1000, CaT wrote:
> > --- arch/i386/kernel/amdk6plus.c.old    Thu May  2 18:51:13 2002
> > +++ arch/i386/kernel/amdk6plus.c        Thu May  2 18:51:17 2002
> > @@ -117,4 +117,4 @@
> >  MODULE_LICENSE ("GPL");
> >  module_init(PowerNow_k6plus_init);
> >  module_exit(PowerNow_k6plus_exit);
> > -__initcall (PowerNOW_k6plus_init);
> > +__initcall (PowerNow_k6plus_init);
> > 
> 
> Hmm, that looks really odd - module_init() should be identical to __initcall
> when built into the kernel.  Copied to the cpufreq list.
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

