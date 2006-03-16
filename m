Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWCPI1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWCPI1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbWCPI1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:27:48 -0500
Received: from [213.91.10.50] ([213.91.10.50]:32975 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1750763AbWCPI1r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:27:47 -0500
Date: Thu, 16 Mar 2006 09:22:44 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: [ot] VIA southbridge strangeness (was: sis96x compiled in by error: delay of one minute at boot)
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <vp9VZWCx.1142497364.7674680.khali@localhost>
In-Reply-To: <Pine.LNX.4.61.0603152359170.20859@yvahk01.tjqt.qr>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Etienne Lorrain" <etienne_lorrain@yahoo.fr>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Thu, 16 Mar 2006 09:22:46 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jan,

On 2006-03-15, Jan Engelhardt wrote:
> > > I have this lspci:
> > > (...)
> > > 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> > > (...)
> > > 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> >
> > Off-topic, but it's quite strange. Your south bridge cannot be a
> > VT8237R and a VT8235 at the same time...
>
> Where does it say that the southbridge is 35 and 37 at the same time?
> (The only thing that's different between the two lspci lines is the
> vtABCD number...)

"The only thing that's different is the thing you said was different."
:)

It looked strange to me because I have two systems with a VT8237R and on
both, lspci says "VT8237" for both the PCI and the ISA bridges. So the
result provided by Etienne suggests that a different (supposedly
earlier) version of the VT8237R has a different ISA bridge sub-device
embedded.

Not that it really matters, anyway, so I probably shouldn't have
commented on it in the first place.

> Or it looks like there's another of these "strange" cases:
>
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
> MVP3/Pro133x AGP]
> 0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South]
> (rev 23)

There are many of these, indeed. South bridges include several
sub-devices, and it is very frequent that chip manufacturers do not
upgrade all these sub-devices when they release a new version of their
chip.

My original comment was really related to the specific case of the
VT8237R, not general.

Thanks,
--
Jean Delvare
