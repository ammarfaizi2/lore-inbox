Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269441AbUHZTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269441AbUHZTUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269472AbUHZTTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:19:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61926 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269441AbUHZTPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:15:09 -0400
Date: Thu, 26 Aug 2004 21:15:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-pre2
Message-ID: <20040826191501.GA12772@fs.tum.de>
References: <412E012F.4050503@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412E012F.4050503@ttnet.net.tr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 06:26:39PM +0300, O.Sezer wrote:

> Hi Marcelo:
> 
> > Also a bunch of gcc 3.4 fixes, hopefully we are done
> > with that now.
> 
> Fairly close, but not complete. You need the two patches at:
>...

I've found six compile errors in -pre2 with gcc 3.4 I'll send patches 
for.

There are still tons of warnings for lvalues and a few other warnings, 
but I don't see a pressing need to fix these:

They are not a real problem with gcc 3.4, and whether gcc 3.5 will ever 
be supported as compiler for kernel 2.4 is a question whose answer lies 
far in the future.


> Regards,
> Ozkan.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

