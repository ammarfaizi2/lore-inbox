Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTKLQux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTKLQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:50:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45773 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263880AbTKLQuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:50:51 -0500
Date: Wed, 12 Nov 2003 17:50:31 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] modprobe sch_htb fails
Message-ID: <20031112165031.GA5962@fs.tum.de>
References: <bld5lc$p3n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bld5lc$p3n$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 02:02:56AM +0200, Sven Köhler wrote:
> Today i recompiled my kernel (version 2.4.22) to make my first steps 
> towards traffic shaping.
> 
> I found out, that the module sch_htb cannot be loaded.
> I can't tell why. Every option under "Networking Options"->"QoS and/or 
> fairqueuing" was either marked to be compiled statically or as a module 
> if possible.
> 
> I guess it's only a "bug" in the dependencies or something similar.
> If you need anything to reproduce the "bug", i can send you my .config 
> or anything you need.
> 
> 
> "modprobe sch_htb" failed with:
> 
> /lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
> qdisc_get_rtab
>...

Does this problem still occur in 2.4.23-rc1?

If yes, please send your .config.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

