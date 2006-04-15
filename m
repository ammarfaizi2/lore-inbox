Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWDOJNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWDOJNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 05:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWDOJNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 05:13:07 -0400
Received: from mgw-ext12.nokia.com ([131.228.20.171]:1100 "EHLO
	mgw-ext12.nokia.com") by vger.kernel.org with ESMTP
	id S1751601AbWDOJNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 05:13:05 -0400
Date: Sat, 15 Apr 2006 11:56:56 +0300 (EEST)
From: Samuel Ortiz <samuel.ortiz@nokia.com>
X-X-Sender: samuel@irie
Reply-To: samuel.ortiz@nokia.com
To: ext Adrian Bunk <bunk@stusta.de>
cc: Jean Tourrilhes <jt@hpl.hp.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
In-Reply-To: <20060414172326.GA15022@stusta.de>
Message-ID: <Pine.LNX.4.58.0604151151200.1032@irie>
References: <20060414114446.GL4162@stusta.de> <20060414164203.GA24146@bougret.hpl.hp.com>
 <20060414172326.GA15022@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Apr 2006 08:57:00.0323 (UTC) FILETIME=[8EAE5F30:01C6606A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, ext Adrian Bunk wrote:

> On Fri, Apr 14, 2006 at 09:42:03AM -0700, Jean Tourrilhes wrote:
>
> > 	Hi,
>
> Hi Jean,
>
> > 	You now need to send those patches to :
> > 		Samuel.Ortiz@nokia.com
>
> Samuel, please send a patch to update MAINTAINERS.
Will do.

>
> > 	Personally, I don't see what this patch buy us...
>
> It makes the kernel image smaller.
It's not a lot, but it does make the kernel image smaller.
Those 3 symbols do not need to be exported as they are not used anywhere
in the modularized parts of the IrDA stack. So, the patch looks good to
me.

Cheers,
Samuel.

> > 	Jean
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>

