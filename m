Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWAMLOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWAMLOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWAMLOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:14:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5641 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964858AbWAMLOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:14:32 -0500
Date: Fri, 13 Jan 2006 12:14:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [drivers/block/ps2esdi.o] Error 1
Message-ID: <20060113111432.GE29663@stusta.de>
References: <20060110202300.M85828@linuxwireless.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110202300.M85828@linuxwireless.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 02:25:14PM -0600, Alejandro Bonilla wrote:
> Hi,
> 
> While building the Linus-git tree I got some errors. I Updated the last time
> at 1:PM EST
> 
>   LD      drivers/base/built-in.o
>   CC      drivers/block/floppy.o
>   CC      drivers/block/loop.o
>   CC      drivers/block/ps2esdi.o
> In file included from drivers/block/ps2esdi.c:42:
> include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move
> your driver to the new sysfs api"
> drivers/block/ps2esdi.c: In function 'ps2esdi_getgeo':
> drivers/block/ps2esdi.c:1064: error: dereferencing pointer to incomplete type
> drivers/block/ps2esdi.c:1065: error: dereferencing pointer to incomplete type
> drivers/block/ps2esdi.c:1066: error: dereferencing pointer to incomplete type
> make[3]: *** [drivers/block/ps2esdi.o] Error 1
>...

Don't say "no" at
  Code maturity level options
    Prompt for development and/or incomplete code/drivers
      Select only drivers expected to compile cleanl

> .Alejandro

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

