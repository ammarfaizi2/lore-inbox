Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132604AbRDOI3k>; Sun, 15 Apr 2001 04:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRDOI3a>; Sun, 15 Apr 2001 04:29:30 -0400
Received: from mail1.rdc2.ab.home.com ([24.64.2.48]:749 "EHLO
	mail1.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S132604AbRDOI3R>; Sun, 15 Apr 2001 04:29:17 -0400
Message-ID: <3ADA5C4C.748D0916@home.com>
Date: Sun, 15 Apr 2001 20:43:24 -0600
From: "Matthew W. Lowe" <swds.mlowe@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 - Module problems?
In-Reply-To: <Pine.LNX.4.21.0104160037230.19394-100000@maelstrom.localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed that, it fixed my one NIC... The 3COM. Or I assume it did, because
it shows up in ifconfig now, unlike the other one Unfortunately I still can't
ping the local host (destination net unreachable). I think that might just be a
byproduct of my main external card not working. Anyway, I double checked the
settings in both config files for the old kernel and the new one, the realtek
should be covered under the ne2000 pci mod. I built this directly into the
kernel and it still doesn't seem to be working. Anyone have any ideas?
Thanks,
  Matt
ecksfantom@home.com wrote:

> I had the same problem when i upgraded to 2.4.2.
> Upgrading to the latest modutils
> (ftp://ftp.kernel.org/pub/linux/utils/modutils/v2.4/modutils-2.4.5.tar.gz)
> should get you going again.
>
> ~Jarrod
>
> On Sun, 15 Apr 2001, Matthew W. Lowe wrote:
>
> > I just tried to upgrade from whatever kernel comes with redhat to 2.4.3.
> > The build, install and such was smooth. When I got to starting up,
> > everything appeared to work, until it got to my NIC cards. Neither of
> > them loaded properly. I've built in the EXACT same module for the NICs
> > as I did the previous kernel. They were the NE2000 PCI module and the
> > 3C59X module. The two NICs I have are: Realtek 8029 PCI, 3COM Etherlink
> > III ISA. Both are PNP, the etherlink is NOT the one with the b extention
> > at the end.
> >
> > Any help would be greatly appriciated.
> >
> > Thanks,
> >    Matt
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

