Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293006AbSBVVjH>; Fri, 22 Feb 2002 16:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293008AbSBVVi7>; Fri, 22 Feb 2002 16:38:59 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:26379 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293006AbSBVVil>; Fri, 22 Feb 2002 16:38:41 -0500
Date: Fri, 22 Feb 2002 22:36:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: G?rard Roudier <groudier@free.fr>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222223638.B7238@suse.cz>
In-Reply-To: <3C76597C.60318465@mandrakesoft.com> <20020221213342.T1547-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020221213342.T1547-100000@gerard>; from groudier@free.fr on Thu, Feb 21, 2002 at 09:39:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 09:39:20PM +0100, G?rard Roudier wrote:

> On Fri, 22 Feb 2002, Jeff Garzik wrote:
> 
> > Vojtech Pavlik wrote:
> > >
> > > On Fri, Feb 22, 2002 at 02:16:39PM +0000, Arjan van de Ven wrote:
> > >
> > > > > I think it'd be even better if the chipset drivers did the probing
> > > > > themselves, and once they find the IDE device, they can register it with
> > > > > the IDE core. Same as all the other subsystem do this.
> > > >
> > > > Please send me your scsi subsystem then ;)
> > >
> > > I must agree that SCSI controllers aren't doing their probing in a
> > > uniform and clean way even on PCI, but at least they do the probing
> > > themselves and don't have the mid-layer SCSI code do it for them like
> > > IDE.
> >
> > Only 1-2 SCSI drivers do PCI probing "the right way"...  IIRC aic7xxx is
> > one of them.
> 
> Could you, please, not mix PCI probing and SCSI probing.

I think we're talking about PCI probing all the time ONLY.

> Average user does not care about PCI probing. But it does care on booting
> the expected kernel image and mounting the expected partitions.
> It also doesn't care of code aesthetical issue even with free software
> since average user is not a kernel hacker.
>   Gérard.

-- 
Vojtech Pavlik
SuSE Labs
