Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRKNRw6>; Wed, 14 Nov 2001 12:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRKNRwi>; Wed, 14 Nov 2001 12:52:38 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:65290 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S273269AbRKNRw3>;
	Wed, 14 Nov 2001 12:52:29 -0500
Message-ID: <3BF29DC4.B1BD0F1B@nyc.rr.com>
Date: Wed, 14 Nov 2001 11:37:24 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre4 fails to build in setup.c
In-Reply-To: <fa.kvqcg8v.1d3c0qv@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is in the archives.  you'll find a patch here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100559812101821&w=2



Chris Meadors wrote:
> 
> I don't think I've seen this yet.
> 
> Build failed with this error:
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c
> -o setup.o setup.c
> setup.c: In function `c_start':
> setup.c:2791: subscripted value is neither array nor pointer
> setup.c:2792: warning: control reaches end of non-void function
> make[1]: *** [setup.o] Error 1
> make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 
> My "grep ^CONFIG .config" is attatched.
> 
> -Chris
> --
> Two penguins were walking on an iceberg.  The first penguin said to the
> second, "you look like you are wearing a tuxedo."  The second penguin
> said, "I might be..."                         --David Lynch, Twin Peaks
> 
>   ------------------------------------------------------------------------
>              Name: config
>    config    Type: Plain Text (TEXT/PLAIN)
>          Encoding: BASE64
