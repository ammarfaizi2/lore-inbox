Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbUKVNfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUKVNfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKVNfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:35:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53520 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262092AbUKVNdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:33:46 -0500
Date: Mon, 22 Nov 2004 14:33:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-ID: <20041122133344.GA19419@stusta.de>
References: <20041121220251.GE13254@stusta.de> <1101108672.2843.55.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101108672.2843.55.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:31:12AM +0300, Evgeniy Polyakov wrote:
> On Mon, 2004-11-22 at 01:02, Adrian Bunk wrote:
> > Hi Evgeniy,
> 
> Hello, Adrian.

Hi Evgeniy,

> > drivers/w1/Makefile in recent 2.6 kernels contains:
> >   obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
> >   ds9490r-objs    := dscore.o
> > 
> > Is there a reason, why dscore.c isn't simply named ds9490r.c ?
> 
> dscore.c is a core function set to work with ds2490 chip.
> ds9490* is built on top of it.
> Any vendor can create it's own w1 bus master using this chip, 
> not ds9490.

if it was built on top of it, I'd have expected ds9490r.o to contain 
additional object files.

How would a different w1 bus master chip look like in 
drivers/w1/Makefile?

> 	Evgeniy Polyakov

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

