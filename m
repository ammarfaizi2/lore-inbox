Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVAOFYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVAOFYs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVAOFYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:24:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34321 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262208AbVAOFXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:23:51 -0500
Date: Sat, 15 Jan 2005 06:23:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Dyck <david.dyck@fluke.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Steffen Moser <lists@steffen-moser.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc2
Message-ID: <20050115052349.GG4274@stusta.de>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de> <20050114231712.GH3336@logos.cnet> <Pine.LNX.4.51.0501141853270.222@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0501141853270.222@dd.tc.fluke.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 06:58:11PM -0800, David Dyck wrote:
> On Fri, 14 Jan 2005 at 21:17 -0200, Marcelo Tosatti <marcelo.tosatti@cyclad...:
> 
> > David, this also fix your problem.
> 
> 
> Sorry, no
> 
> I tried your patch to drivers/char/tty_io.c
> (using EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL)
> 
> My first test (apply the patch, make bzImage and modules again
> results in the same errors as before
> 
> # insmod $PWD/cyclades.o
> /lib/modules/2.4.29-rc2/kernel/drivers/char/cyclades.o: unresolved symbol tty_ldisc_flush
> /lib/modules/2.4.29-rc2/kernel/drivers/char/cyclades.o: unresolved symbol tty_wakeup
> 
> $ grep tty_ldisc_flush /proc/ksyms
> c01db0dc tty_ldisc_flush_R__ver_tty_ldisc_flush

Please send:
- your .config
- the output of
    bash scripts/ver_linux

>  heading back to 2.4.29-pre2...
>      David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

