Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282872AbRLBNDx>; Sun, 2 Dec 2001 08:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282870AbRLBNDl>; Sun, 2 Dec 2001 08:03:41 -0500
Received: from mail114.mail.bellsouth.net ([205.152.58.54]:33543 "EHLO
	imf14bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S277568AbRLBNDd>; Sun, 2 Dec 2001 08:03:33 -0500
Message-ID: <3C0A269F.D2B1D3@mandrakesoft.com>
Date: Sun, 02 Dec 2001 08:03:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Keith Owens <kaos@ocs.com.au>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <25560.1007294074@ocs3.intra.ocs.com.au> <20011202133314.B717@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Sun, Dec 02, 2001 at 10:54:34PM +1100, Keith Owens wrote:
> > With kbuild 2.5 the generation of ext2_all.c (I prefer
> > ext2_static.c) can be automated.

> > The code that is normally linked into xxxx.o has to be manually changed
> > to add XXXX_STATIC before a make_static(xxxx) command can be added.

> Even this doesn't have to be done manually. Everything that is
> not covered by EXPORT_SYMBOL() in this case can be static, since

And if !MODULE, then even EXPORT_SYMBOL symbols can become static, if
they are not used outside the compilation unit.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

