Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292880AbSBVOpg>; Fri, 22 Feb 2002 09:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSBVOp0>; Fri, 22 Feb 2002 09:45:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33542 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292880AbSBVOpS>;
	Fri, 22 Feb 2002 09:45:18 -0500
Message-ID: <3C76597C.60318465@mandrakesoft.com>
Date: Fri, 22 Feb 2002 09:45:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <3C764B7C.2000609@evision-ventures.com>; <20020222150323.A5530@suse.cz> <3C7652C7.96D0B730@redhat.com> <20020222154011.B5783@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Fri, Feb 22, 2002 at 02:16:39PM +0000, Arjan van de Ven wrote:
> 
> > > I think it'd be even better if the chipset drivers did the probing
> > > themselves, and once they find the IDE device, they can register it with
> > > the IDE core. Same as all the other subsystem do this.
> >
> > Please send me your scsi subsystem then ;)
> 
> I must agree that SCSI controllers aren't doing their probing in a
> uniform and clean way even on PCI, but at least they do the probing
> themselves and don't have the mid-layer SCSI code do it for them like
> IDE.

Only 1-2 SCSI drivers do PCI probing "the right way"...  IIRC aic7xxx is
one of them.

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
