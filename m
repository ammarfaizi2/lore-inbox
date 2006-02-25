Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWBYQcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWBYQcX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWBYQcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:32:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964774AbWBYQcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:32:23 -0500
Date: Sat, 25 Feb 2006 17:32:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Veliath <andrewtv@usa.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS msnd build failure
Message-ID: <20060225163221.GZ3674@stusta.de>
References: <9a8748490602250824u34e664fandc56c20394367926@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602250824u34e664fandc56c20394367926@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 05:24:10PM +0100, Jesper Juhl wrote:

> During some build tests of 2.6.16-rc4-mm2 with  'make randconfig'  I
> found this build failure :
> 
>   ...
>   LD      drivers/built-in.o
>   CC      sound/sound_core.o
>   CC      sound/sound_firmware.o
>   CC      sound/oss/msnd.o
> make[2]: *** No rule to make target `/etc/sound/msndperm.bin', needed
> by `sound/oss/msndperm.c'.  Stop.
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [sound/oss] Error 2
> make: *** [sound] Error 2
> 
> I must admit I don't know how to fix it, so I'll have to just report it.

That's expected if the .config contains CONFIG_STANDALONE=n

> Jesper Juhl <jesper.juhl@gmail.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

