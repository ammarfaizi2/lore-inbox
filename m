Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263922AbRFRK5Y>; Mon, 18 Jun 2001 06:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263928AbRFRK5F>; Mon, 18 Jun 2001 06:57:05 -0400
Received: from iris.kkt.bme.hu ([152.66.114.1]:56594 "HELO iris.kkt.bme.hu")
	by vger.kernel.org with SMTP id <S263922AbRFRK5C>;
	Mon, 18 Jun 2001 06:57:02 -0400
Date: Mon, 18 Jun 2001 12:57:00 +0200 (CEST)
From: PALFFY Daniel <dpalffy@kkt.bme.hu>
To: Thomas Davis <tadavis@lbl.gov>
cc: Guus Sliepen <guus@warande3094.warande.uu.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Looking for ifenslave.c
In-Reply-To: <3B292578.1887366D@lbl.gov>
Message-ID: <Pine.LNX.4.21.0106181249140.18271-100000@iris.kkt.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Thomas Davis wrote:

> Guus, there isn't a really official version of it..
> 
> At http://pdsf.nersc.gov/linux/ifenslave.c is the last version I
> produced, that works with bonding in v2.2 and v2.4 kernels.

> Guus Sliepen wrote:
> > 
> > Hello,
> > 
> > The Ethernet bonding module is useless without ifenslave.c. I'm making a Debian
> > package for it, and I have tried to find the "offical" distribution of this
> > small program. I could not find an authorative source, instead a lot of copies
> > and patched versions are scattered around the Internet (I maintain a patched
> > version myself too).
> > 
> > I would like to combine all the useful extra features and patches into this
> > Debian package, so if you know of a patched version or maintain one yourself,
> > please send it to me.

The only bonding driver and ifenslave that worked for me was the patched
version from http://sourceforge.net/projects/bonding . It runs fine over a
quad starfire card, with vlans over it (ben's patch). You might consider
packaging the ifenslave from that patch, and packaging the bonding driver
as a kernel patch...

--
Dani
			...and Linux for all.


