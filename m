Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTICRIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTICRHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:07:00 -0400
Received: from alfarrabio.di.uminho.pt ([193.136.20.210]:34265 "HELO
	alfarrabio.di.uminho.pt") by vger.kernel.org with SMTP
	id S263980AbTICRFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:05:33 -0400
Subject: Re: Problems compiling kernel 2.4.22
From: Alberto Manuel =?ISO-8859-1?Q?Brand=E3o_Sim=F5es?= 
	<albie@alfarrabio.di.uminho.pt>
Reply-To: albie@alfarrabio.di.uminho.pt
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0309031257410.28170@chaos>
References: <1062606509.623.20.camel@eremita.di.uminho.pt>
	 <1062607884.623.23.camel@eremita.di.uminho.pt>
	 <Pine.LNX.4.53.0309031257410.28170@chaos>
Content-Type: text/plain; charset=iso-8859-15
Organization: Departamento de  =?ISO-8859-1?Q?=20Inform=C3=A1tica?= - Universidade do Minho
Message-Id: <1062609049.860.4.camel@eremita.di.uminho.pt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 03 Sep 2003 18:10:50 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 17:58, Richard B. Johnson wrote:
> On Wed, 3 Sep 2003, Alberto Manuel [ISO-8859-1] Brandão Simões wrote:
> > On Wed, 2003-09-03 at 17:28, Alberto Manuel Brandão Simões wrote:
> > > [1.] One line summary of the problem:
> > >  modules symbols broken references
> > >
> > > [2.] Full description of the problem/report:
> > >  when I make 'make modules_install' I get:
> > >  depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/net/ipv4/ipip.o
> > >  depmod:         ip_send_check
> > >  depmod:         register_netdevice
> > >  ..
> > >
> > > and so on, and not only for these modules: vfat, smbfs, msdos, etc
> > >
> > > By the way, when I tried to ssh to paste more information, I got in the
> > > console:
> 
> [SNIPPED...]
> 
> BYW. Did you try booting the new system, THEN, executing `depmod -a` ?
ok. In this case, it does not give any broken reference.
But, then, why does make modules_install run depmod if we know (almost
certain) that it will give broken references?

But, I need some more help. I can't load any ACPI modules, getting a No
such device as answer. I don't have also a /proc/acpi directory.

Thanks for any help.
Alberto 
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 

