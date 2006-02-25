Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWBYDjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWBYDjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 22:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWBYDjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 22:39:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23058 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932602AbWBYDjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 22:39:02 -0500
Date: Sat, 25 Feb 2006 04:38:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc4-mm2: drivers/isdn/hysdn/hysdn_net.c module_param() compile error
Message-ID: <20060225033855.GG3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
> +remove-module_parm.patch
>...
>  Current 2.6.16 queue.  Some of these are a bit questionable at this stage.
>...

This causes the following compile error:

<--  snip  -->

...
  CC [M]  drivers/isdn/hysdn/hysdn_net.o
drivers/isdn/hysdn/hysdn_net.c:27: error: syntax error before 'int'
drivers/isdn/hysdn/hysdn_net.c:27: error: syntax error before ',' token
drivers/isdn/hysdn/hysdn_net.c:27: error: 'param_set_unsigned' undeclared here (not in a function)
drivers/isdn/hysdn/hysdn_net.c:27: error: syntax error before 'int'
drivers/isdn/hysdn/hysdn_net.c:27: error: 'param_get_unsigned' undeclared here (not in a function)
make[3]: *** [drivers/isdn/hysdn/hysdn_net.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

