Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbRGKL3W>; Wed, 11 Jul 2001 07:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbRGKL3N>; Wed, 11 Jul 2001 07:29:13 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13188 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267277AbRGKL26>;
	Wed, 11 Jul 2001 07:28:58 -0400
Message-ID: <3B4C3875.C61EF874@mandrakesoft.com>
Date: Wed, 11 Jul 2001 07:28:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ookhoi@dds.nl
Cc: Wakko Warner <wakko@animx.eu.org>, daniel sheltraw <l5gibson@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: CardBus and PCI
In-Reply-To: <F34guA8M6XQQez1enAq000153a1@hotmail.com> <3B4B6DB8.F26663A1@mandrakesoft.com> <20010710213830.A13597@animx.eu.org> <3B4BB3B0.F6FB3443@mandrakesoft.com> <20010711104049.F7424@humilis>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ookhoi wrote:
> 
> Hi Jeff Garzik,
> 
> > Wakko Warner wrote:
> > > > > If a CardBus card is in a slot at boot time is it treated as PCI device
> > > > > would be? Is it just another device on another PCI bus?
> > > >
> > > > In kernel 2.4 and using kernel cardbus support, yes.
> > >
> > > But is it possible for it to be configured at boot time (like to use it for
> > > nfsroot)
> >
> > In kernel 2.4 and using kernel cardbus support, yes.
> 
> It didn't work for me a few kernels back as the cardbus nic got active
> after the assignment of the ip address and after the nfsroot mount
> (which both failed because of that).

That's an ordering problem that's easy to fix...

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
