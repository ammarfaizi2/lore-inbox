Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUJNOUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUJNOUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUJNOUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:20:07 -0400
Received: from witte.sonytel.be ([80.88.33.193]:39655 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265127AbUJNOUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:20:01 -0400
Date: Thu, 14 Oct 2004 16:18:59 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: David Howells <dhowells@redhat.com>, Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules? 
In-Reply-To: <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com>
Message-ID: <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be>
References: <Pine.LNX.4.61.0410141357380.877@scrub.home> 
 <Pine.LNX.4.61.0410132346080.7182@scrub.home> <1092369784.25194.225.camel@bach>
 <20040812092029.GA30255@devserv.devel.redhat.com> <20040811211719.GD21894@kroah.com>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Richard B. Johnson wrote:
> The new kernel build environment is also corrupt. On
> this system, it takes 45 seconds to perform:
> 
> make clean
> make bzImage

And how long does `make oldconfig' take?

> With the new build system, same disk, same kernel
> configuration, it takes 14 minutes. And, you can't

BTW, how do you choose the old/new build system with the same kernel?

> even see what the compiler doesn't like.

make V=1?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
