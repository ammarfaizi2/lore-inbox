Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268099AbTGIKL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbTGIKL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:11:26 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:24539 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S268099AbTGIKGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:06:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Wed, 9 Jul 2003 20:22:07 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       Nick Sanders <sandersn@btinternet.com>, Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200307070317.11246.kernel@kolivas.org> <Pine.LNX.4.53.0307072028440.1288@montezuma.mastecende.com> <200307091211.57017.m.c.p@wolk-project.de>
In-Reply-To: <200307091211.57017.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307092022.07723.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 20:12, Marc-Christian Petersen wrote:
> On Tuesday 08 July 2003 02:31, Zwane Mwaikambo wrote:
>
> Hi Zwane,
>
> > > - An Xterm needs ~30 seconds to open up while "make -j16 bzImage
> > > modules" - An Xterm needs ~15 seconds to open up while "make -j8
> > > bzImage modules" - XMMS does _not_ skip mp3's while above.
> >
> > How fast is your box? RAM? disks? I'm personally more interested in 1-2
> > make -j2 bzImage going
>
> - Celeron 1,3GHz
> - 512MB RAM
> - 1GB SWAP (2 IDE disks, ~512MB on each disk)
> - ATA100 Maxtor 60GB HDD
> - ATA100 Fujitsu 40GB
>
> Now I am running 2.5.74-mm3, xterm needs about 5 seconds to open up, but
> the whole system is again in a snail mode. XMMS does not skip.

Well this is no different to the O3 patch on mm2 so it's no surprise :)

Con

>
> > > - Kmail is almost unusable while above (stops for about 5 secs every
> > > 15-20 secs). KMail is also very slow while the machine is doing
> > > nothing. - X runs with nice 0, prio 15 (nice -11 is prio 4, does not
> > > make difference)
> >
> > Looking at above load i'm not entirely surprised, but i presume you're
> > going to name a kernel which can handle that and still complete the
> > builds withing a sane time frame.
>
> For example, my wolk4 tree can handle it very well. 2.4-aa can handle it
> very well too.
>
> ciao, Marc

