Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSBTH44>; Wed, 20 Feb 2002 02:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290285AbSBTH4q>; Wed, 20 Feb 2002 02:56:46 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:4871 "EHLO jubjub.wizard.com")
	by vger.kernel.org with ESMTP id <S287425AbSBTH41>;
	Wed, 20 Feb 2002 02:56:27 -0500
Date: Tue, 19 Feb 2002 23:55:53 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: NyQuist <NyQuist@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: opengl-nvidia not compiling
Message-ID: <20020220075553.GA25006@wizard.com>
In-Reply-To: <20020220015358.A26765@suse.de> <1014182978.21280.14.camel@imyourhandiman> <1014186943.1387.2.camel@stinky.pussy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014186943.1387.2.camel@stinky.pussy>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux/2.5.2 (i686)
X-uptime: 11:42pm  up 2 days, 23:26,  2 users,  load average: 0.34, 0.34, 0.20
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 06:35:42AM +0000, NyQuist wrote:
> On Wed, 2002-02-20 at 05:29, lee johnson wrote:
> > hi..
> > 
> >    hope i'm not repeating a message here if so sorry,- but by any chance
> > does anyone know that nvidia opengl isn't compiling with 2.5.5pre1..
> > 
> > thx :-)
> > lee
> > -==
> > 
> don't wanna sound nasty, but you are :)
> I wouldn't use an nvidia card with 2.5, this is cut from a previous
> message on the lkml.
> 
> <----->
>  > nv.c:1438: incompatible type for argument 4 of
> `remap_page_range_Reb32c755'
>  > nv.c:1438: too few arguments to function `remap_page_range_Reb32c755'
>  > make[2]: *** [nv.o] Error 1
> 
>  Assuming you get lucky, and manage to fix up all the compile
>  errors in the source you have, chances are that the same
>  interface changes will break the binary only part too.
>  So it'll compile, link, and likely explode as soon as you
>  try to use it.
> 
>  It's likely that only nvidia can help you here.

        Just to add something related, but unrelated to the NVIDIA problem 
above, this is the same exact error I received when I compiled any kernel > 
2.5.2 with ALSA 0.5.* and ALSA 0.9.*. Hopefully with ALSA being in 2.5.5pre1, 
this will be taken care of.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

