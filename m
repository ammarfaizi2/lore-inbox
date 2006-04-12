Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWDLJ3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWDLJ3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDLJ3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:29:08 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:16828 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751097AbWDLJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:29:07 -0400
Date: Wed, 12 Apr 2006 11:29:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Ungerer <gerg@snapgear.com>,
       dwmw2@infradead.org
Subject: Re: [PATCH] mtd, nettel: fix build error and implicit declaration
Message-ID: <20060412092906.GA6243@wohnheim.fh-wedel.de>
References: <200604112041.49689.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604112041.49689.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 April 2006 20:41:49 +0200, Jesper Juhl wrote:
> 
> I just hit the following error and warning : 
>   drivers/mtd/maps/nettel.c: In function `nettel_init':
>   drivers/mtd/maps/nettel.c:418: error: `ROOT_DEV' undeclared (first use in this function)
>   drivers/mtd/maps/nettel.c:418: error: (Each undeclared identifier is reported only once
>   drivers/mtd/maps/nettel.c:418: error: for each function it appears in.)
>   drivers/mtd/maps/nettel.c:418: warning: implicit declaration of function `MKDEV'
>   make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
>   make[2]: *** [drivers/mtd/maps] Error 2
>   make[1]: *** [drivers/mtd] Error 2
> The patch fixes the missing ROOT_DEV declaration by including linux/root_dev.h
> and fixes the implicit declaration of MKDEV by including linux/kdev_t.h .

I guess you could just send this to Andrew.

> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Acked-by: Joern Engel <joern@wh.fh-wedel.de>

Jörn

-- 
To my face you have the audacity to advise me to become a thief - the worst
kind of thief that is conceivable, a thief of spiritual things, a thief of
ideas! It is insufferable, intolerable!
-- M. Binet in Scarabouche
