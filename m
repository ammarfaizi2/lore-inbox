Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbTF1CZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 22:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTF1CZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 22:25:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25820 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265023AbTF1CZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 22:25:23 -0400
Date: Sat, 28 Jun 2003 04:39:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: support@moxa.com.tw, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] remove two unused variables from mxser.c
Message-ID: <20030628023935.GQ24661@fs.tum.de>
References: <20030619231222.GF29247@fs.tum.de> <20030620050950.32FB52C11D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620050950.32FB52C11D@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:31:06PM +1000, Rusty Russell wrote:
> In message <20030619231222.GF29247@fs.tum.de> you write:
> > The patch below removes two unused variables from drivers/char/mxser.c .
> 
> While you're there, would you fix the init returning "-1" for no good
> reason at the bottom, too?  (I don't think they really meant EPERM).

There is at least one other driver under drivers/char/ doing the 
same...

Which return code do you suggest?

> Thanks,
> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

