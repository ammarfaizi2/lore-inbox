Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291675AbSBTGps>; Wed, 20 Feb 2002 01:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291678AbSBTGpi>; Wed, 20 Feb 2002 01:45:38 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:22172 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S291675AbSBTGp3>; Wed, 20 Feb 2002 01:45:29 -0500
Subject: Re: opengl-nvidia not compiling
From: NyQuist <NyQuist@ntlworld.com>
To: lee johnson <lee@imyourhandiman.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1014182978.21280.14.camel@imyourhandiman>
In-Reply-To: <20020220015358.A26765@suse.de> 
	<1014182978.21280.14.camel@imyourhandiman>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 06:35:42 +0000
Message-Id: <1014186943.1387.2.camel@stinky.pussy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 05:29, lee johnson wrote:
> hi..
> 
>    hope i'm not repeating a message here if so sorry,- but by any chance
> does anyone know that nvidia opengl isn't compiling with 2.5.5pre1..
> 
> thx :-)
> lee
> -==
> 
don't wanna sound nasty, but you are :)
I wouldn't use an nvidia card with 2.5, this is cut from a previous
message on the lkml.

<----->
 > nv.c:1438: incompatible type for argument 4 of
`remap_page_range_Reb32c755'
 > nv.c:1438: too few arguments to function `remap_page_range_Reb32c755'
 > make[2]: *** [nv.o] Error 1

 Assuming you get lucky, and manage to fix up all the compile
 errors in the source you have, chances are that the same
 interface changes will break the binary only part too.
 So it'll compile, link, and likely explode as soon as you
 try to use it.

 It's likely that only nvidia can help you here.
 Same goes for any other binary only module during a devel series.
<------>

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


