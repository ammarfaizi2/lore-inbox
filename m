Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUL0D24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUL0D24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 22:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUL0D24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 22:28:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15621 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261745AbUL0D2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 22:28:53 -0500
Date: Mon, 27 Dec 2004 04:28:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Scott Mollica <scott@exit-109.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM
Message-ID: <20041227032843.GF3002@stusta.de>
References: <20041224042234.10308.qmail@web51810.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224042234.10308.qmail@web51810.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 08:22:34PM -0800, Scott Mollica wrote:

> [1.] One line summary of the problem: 
> Problem 
> make utility exits with an Error 2 when making
> linux-2.6.9-final.  
>  
> [2.] Full description of the problem/report:
> make seems to choke in the
> "drivers/char/drm/gamma_drv.c" section during make
> (output from make is attached at bottom).
>...
>   CC [M]  drivers/char/drm/gamma_drv.o
> In file included from drivers/char/drm/gamma_drv.c:42:
> drivers/char/drm/gamma_context.h: In function
> `gamma_context_switch_complete':
> drivers/char/drm/gamma_context.h:193: error: structure
> has no member named `next_buffer'
>...
> make[3]: *** [drivers/char/drm/gamma_drv.o] Error 1
>...

It seems you answered "yes" to

  Code maturity level options
    Prompt for development and/or incomplete code/drivers

and "no" to

  Code maturity level options
    Prompt for development and/or incomplete code/drivers
      Select only drivers expected to compile cleanly

If you say "yes" to second question, you won't be able to select drivers 
that don't compile.

> Regards,
> Scott Mollica

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

