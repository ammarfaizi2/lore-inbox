Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752120AbWCPLcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbWCPLcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWCPLcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:32:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14859 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752120AbWCPLcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:32:08 -0500
Date: Thu, 16 Mar 2006 12:32:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Cc: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc6-git6 compilation fails (input system)
Message-ID: <20060316113206.GB3914@stusta.de>
References: <441946AA.2070006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441946AA.2070006@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 12:06:18PM +0100, Patrizio Bassi wrote:
> i've a problem with gcc 4.1.0
> 
> 
> LD drivers/ide/built-in.o
> CC drivers/input/input.o
> In file included from drivers/input/input.c:16:
> include/linux/input.h:957: warning: ‘struct input_device_id’ declared
> inside parameter list
> include/linux/input.h:957: warning: its scope is only this definition or
> declaration, which is probably not what you want
> drivers/input/input.c: In function ‘input_register_device’:
> drivers/input/input.c:842: warning: passing argument 3 of
> ‘handler->connect’ from incompatible pointer type
> drivers/input/input.c: In function ‘input_register_handler’:
> drivers/input/input.c:898: warning: passing argument 3 of
> ‘handler->connect’ from incompatible pointer type
>...

Please send your .config .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

