Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUJNOaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUJNOaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUJNOaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:30:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265207AbUJNO1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:27:04 -0400
Date: Thu, 14 Oct 2004 10:25:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: David Howells <dhowells@redhat.com>, Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules? 
In-Reply-To: <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.53.0410141022180.1018@chaos.analogic.com>
References: <Pine.LNX.4.61.0410141357380.877@scrub.home> 
 <Pine.LNX.4.61.0410132346080.7182@scrub.home> <20040811211719.GD21894@kroah.com>
 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
 <30797.1092308768@redhat.com> <20040812111853.GB25950@devserv.devel.redhat.com>
 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
 <10345.1097507482@redhat.com> <1097507755.318.332.camel@hades.cambridge.redhat.com>
 <1097534090.16153.7.camel@localhost.localdomain>
 <1097570159.5788.1089.camel@baythorne.infradead.org> <27277.1097702318@redhat.com>
 <16349.1097752! 349@redhat.com>  <17271.1097756056@redhat.com>
 <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com>
 <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Geert Uytterhoeven wrote:

> On Thu, 14 Oct 2004, Richard B. Johnson wrote:
> > The new kernel build environment is also corrupt. On
> > this system, it takes 45 seconds to perform:
> >
> > make clean
> > make bzImage
>
> And how long does `make oldconfig' take?
>

Don't know.

> > With the new build system, same disk, same kernel
> > configuration, it takes 14 minutes. And, you can't
>
> BTW, how do you choose the old/new build system with the same kernel?
>

You can't. I needed to do a `make oldconfig` as a seperate
operation which wasn't timed. The configuration uses only
12 modules (SCSI disk stuff plus ethernet).

> > even see what the compiler doesn't like.
>
> make V=1?


Try it while making modules!

>
> Gr{oetje,eeting}s,
>
> 						Geert


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

