Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272886AbRIMGpw>; Thu, 13 Sep 2001 02:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272889AbRIMGpm>; Thu, 13 Sep 2001 02:45:42 -0400
Received: from goliath.siemens.de ([194.138.37.131]:62922 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S272886AbRIMGp1>; Thu, 13 Sep 2001 02:45:27 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'Andreas Dilger'" <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org,
        Mandrake cooker list <cooker@linux-mandrake.com>
Subject: RE: FW: [Cooker] rotflags and initrd
Date: Thu, 13 Sep 2001 10:45:45 +0400
Message-ID: <001001c13c1f$b726a360$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20010913003738.F1541@turbolinux.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Sep 13, 2001  09:46 +0400, Borsenkow Andrej wrote:
> > > Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru> writes:
> > > > If kernel mounts rootfs directly, you can pass mount options via
> > > > rootflags boot parameter, like
> > > >
> > > > linux rootflags=data=journal
> > >
> > > the "rootflags" kernel parameter is not documented in
> > > linux/Documentation/kernel-parameters.txt and I can find it in the
> > > whole source only at one place. I'm not sure we should honour
this.
> >
> > Just how "official" the parameter really is? The problem is, you
want
> > root on reiser to be in notail mode (if you boot off root - in any
case,
> > to avoid problems with bootloaders) and remounting reiser later
AFAIK
> > does not change tail conversion mode.
> 
> The rootflags parameter is only a part of the ext3 patch, AFAIK.  It
> is therefore probably in -ac kernels, but not stock Linus kernels.
> Since it is useful by itself, it may be good to submit it as a patch
> to Linus (this was done once along with the rootfstype= patch) but
> I don't think it made it in.
> 

Ah ... well, in this case I speak about Mandrake kernel that includes
ext3. Thank you.

-andrej
