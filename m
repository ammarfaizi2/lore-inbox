Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274268AbRIYANX>; Mon, 24 Sep 2001 20:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274272AbRIYANN>; Mon, 24 Sep 2001 20:13:13 -0400
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:41628
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S274268AbRIYANE>; Mon, 24 Sep 2001 20:13:04 -0400
Message-ID: <004f01c14557$39b8acc0$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David Grant" <davidgrant79@hotmail.com>, "Greg Ward" <gward@python.net>,
        <bugs@linux-ide.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca> <20010922100451.A2229@suse.cz> <OE3183UV8wAddX47sFo00001649@hotmail.com> <20010922110945.B678@gerg.ca> <OE48GTjkifTNRMOKS310000192c@hotmail.com> <20010924103544.A1572@suse.cz> <m1k7yo77v7.fsf@frodo.biederman.org> <20010925004431.A197@suse.cz>
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Date: Mon, 24 Sep 2001 17:15:47 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have multiple machines here that do exactly that. If "PNP OS" is set to
_Yes_, only possible boot devices are initialized. When I boot a machine
with good ol'd DOS (to use Symantec Ghost), the network cards are unusable
unless PNP OS is set to No, because no interrupt has been assigned. And yes,
these are PCI network cards.

----- Original Message -----
From: "Vojtech Pavlik" <vojtech@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David Grant" <davidgrant79@hotmail.com>; "Greg Ward"
<gward@python.net>; <bugs@linux-ide.org>; <linux-kernel@vger.kernel.org>
Sent: Monday, September 24, 2001 3:44 PM
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour


> On Mon, Sep 24, 2001 at 12:37:32PM -0600, Eric W. Biederman wrote:
>
> > > The PnP stuff is for ISA PnP cards. If you don't have those, it's
> > > irrelevant. When "PnP OS Installed" is set to "No", the BIOS does the
> > > ISAPnP initialization. If it is set to "Yes", it skips that step.
Linux
> > > prefers to have the ISAPnP cards pre-initialized, though it can do it
> > > all by itself.
> >
> > "PnP OS Installed" applies to PCI as well as ISA PnP.  The rule is
> > something like all possible boot devices must be initialized but that
> > is all.
>
> Well, I know of no BIOS that would, with PnP OS Installed set to Yes not
> configure all PCI cards in the system.
>
> --
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

