Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTIJRZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTIJRZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:25:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29650 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265337AbTIJRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:25:18 -0400
Date: Wed, 10 Sep 2003 18:57:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: kkeil@suse.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       isdn4linux@listserv.isdn4linux.de
Subject: 2.6.0-test5: ISDN kcapi.c no longer compiles
Message-ID: <20030910165742.GG27368@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:32:05PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test4 to v2.6.0-test5
> ============================================
>...
> Karsten Keil:
>...
>   o next fixes
>...

It seems this change broke the compilation of kcapi.c:

<--  snip  -->

...
  CC      drivers/isdn/capi/kcapi.o
drivers/isdn/capi/kcapi.c: In function `capi_ctr_get':
drivers/isdn/capi/kcapi.c:82: error: dereferencing pointer to incomplete type
drivers/isdn/capi/kcapi.c: In function `capi_ctr_put':
drivers/isdn/capi/kcapi.c:90: error: dereferencing pointer to incomplete type
make[3]: *** [drivers/isdn/capi/kcapi.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

