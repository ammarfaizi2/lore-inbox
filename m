Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTIGKiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 06:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTIGKiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 06:38:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47821 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263011AbTIGKiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 06:38:06 -0400
Date: Sun, 7 Sep 2003 12:37:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: spurious recompiles
Message-ID: <20030907103723.GO14436@fs.tum.de>
References: <20030906201417.GI14436@fs.tum.de> <33384.4.4.25.4.1062887601.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33384.4.4.25.4.1062887601.squirrel@www.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 03:33:21PM -0700, Randy.Dunlap wrote:
> > When doing a "make" inside an already compiled kernel source there
> > shouldn't be anything rebuilt. I've identified three places where this
> > isn't the case in recent 2.6 kernels:
> >
> > 1. ikconfig
> >   CC      kernel/configs.o
> > even when the .config wasn't changed
>...
> I posted a patch based on Sam Ravnborg's comments that might fix it,
> but I haven't verified it yet... The patch is in this message:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106272687506379&w=2
>...

It seems I missed this mail.

The patch in this mail seems to fix the recompiles.

> Thanks,
> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

