Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292967AbSBVTkN>; Fri, 22 Feb 2002 14:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292966AbSBVTkE>; Fri, 22 Feb 2002 14:40:04 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:49956 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S292967AbSBVTj4> convert rfc822-to-8bit; Fri, 22 Feb 2002 14:39:56 -0500
Date: Thu, 21 Feb 2002 21:39:20 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <3C76597C.60318465@mandrakesoft.com>
Message-ID: <20020221213342.T1547-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Feb 2002, Jeff Garzik wrote:

> Vojtech Pavlik wrote:
> >
> > On Fri, Feb 22, 2002 at 02:16:39PM +0000, Arjan van de Ven wrote:
> >
> > > > I think it'd be even better if the chipset drivers did the probing
> > > > themselves, and once they find the IDE device, they can register it with
> > > > the IDE core. Same as all the other subsystem do this.
> > >
> > > Please send me your scsi subsystem then ;)
> >
> > I must agree that SCSI controllers aren't doing their probing in a
> > uniform and clean way even on PCI, but at least they do the probing
> > themselves and don't have the mid-layer SCSI code do it for them like
> > IDE.
>
> Only 1-2 SCSI drivers do PCI probing "the right way"...  IIRC aic7xxx is
> one of them.

Could you, please, not mix PCI probing and SCSI probing.

Average user does not care about PCI probing. But it does care on booting
the expected kernel image and mounting the expected partitions.
It also doesn't care of code aesthetical issue even with free software
since average user is not a kernel hacker.

  Gérard.

