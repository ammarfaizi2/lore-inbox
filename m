Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292881AbSBVOiG>; Fri, 22 Feb 2002 09:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292882AbSBVOh5>; Fri, 22 Feb 2002 09:37:57 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34569 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292881AbSBVOhs>; Fri, 22 Feb 2002 09:37:48 -0500
Date: Fri, 22 Feb 2002 11:28:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Florian Hars <florian@hars.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridges in 2.4.18-rc3
In-Reply-To: <20020222143640.GA22031@bik-gmbh.de>
Message-ID: <Pine.LNX.4.21.0202221128270.29093-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Feb 2002, Florian Hars wrote:

> Marcelo Tosatti wrote:
> > On Fri, 22 Feb 2002, Florian Hars wrote:
> > > Any reason why this:
> > > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.1/0970.html
> > > isn't in rc3? My machine still works as it should.
> > 
> > Do you mean adding the necessary PCI ID's ? 
> 
> That, and adding some code in drivers/ide/via82xxx.c,
>   { "vt8233c", PCI_DEVICE_ID_VIA_8233C, 0x00, 0x2f, VIA_UDMA_100 },
> is right now ifdef'ed out, and the entry for the vt8233a, which is
>   { "vt8233a", PCI_DEVICE_ID_VIA_8233A, 0x00, 0x2f, VIA_UDMA_133 },
> in 2.5.2, is missing (and there is no UDMA_133 in 2.4).
> 
> Right now I am running a 2.4.18-pre9 with a slightly modified
> drivers/ide/(timing.h|via82xxx.c) from 2.5.2, and it works with
> my vt8233a and an UDMA-100 disk, but this is of course not a 
> conservative change. Maybe the patch by Vojtech Pavlik mentioned
> in the message I referred to above is less radical.

Could you please send me this patch ?

Thanks

