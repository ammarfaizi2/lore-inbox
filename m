Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUCGPwc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 10:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbUCGPwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 10:52:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56568 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262208AbUCGPvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 10:51:53 -0500
Date: Sun, 7 Mar 2004 16:51:47 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Daniel Egger <degger@fhm.edu>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: [2.6 patch] MAINTAINERS: remove LAN media entry
Message-ID: <20040307155146.GN22479@fs.tum.de>
References: <20040226225131.GX5499@fs.tum.de> <A93036A2-68C5-11D8-A46E-000A9597297C@fhm.edu> <20040227205446.GZ5499@fs.tum.de> <DC71BC17-69DC-11D8-BD1F-000A9597297C@fhm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC71BC17-69DC-11D8-BD1F-000A9597297C@fhm.edu>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 11:57:11AM +0100, Daniel Egger wrote:
> On Feb 27, 2004, at 9:54 pm, Adrian Bunk wrote:
> 
> >IOW:
> >The entry from MAINTAINER can be removed?
> 
> This one for sure. The same is probably sensible for the
> drivers, too. It's just too confusing to not several
> versions of the driver floating around which need different
> tools. And since the manufacturer propagates their own
> version, the linux one should go...
>...


It's a question whether removing drivers from a stable kernel series is
a good idea, but the following is definitely correct:


--- linux-2.6.4-rc1-mm2/MAINTAINERS.old	2004-03-07 16:47:18.000000000 +0100
+++ linux-2.6.4-rc1-mm2/MAINTAINERS	2004-03-07 16:47:32.000000000 +0100
@@ -1200,12 +1200,6 @@
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
-LANMEDIA WAN CARD DRIVER
-P:	Andrew Stanley-Jones
-M:	asj@lanmedia.com
-W:	http://www.lanmedia.com/
-S:	Supported
- 
 LAPB module
 P:	Henner Eisen
 M:	eis@baty.hanse.de



> Servus,
>       Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

