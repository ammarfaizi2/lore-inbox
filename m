Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbTGETsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbTGETsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:48:12 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:41035 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266441AbTGETsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:48:11 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4 BK compile failure in dmi_scan: `BROKEN_PNP_BIOS' undeclared
Date: Sat, 5 Jul 2003 22:02:40 +0200
User-Agent: KMail/1.5.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200307051356.35663.baldrick@wanadoo.fr> <1057412245.23488.5.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057412245.23488.5.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307052202.40781.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 July 2003 15:37, Alan Cox wrote:
> On Sad, 2003-07-05 at 12:56, Duncan Sands wrote:
> > make[2]: Entering directory `/home/duncan/linux-2.4/arch/i386/kernel'
> > gcc -D__KERNEL__ -I/home/duncan/linux-2.4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon  
> > -nostdinc -iwithprefix include -DKBUILD_BASENAME=dmi_scan  -c -o
> > dmi_scan.o dmi_scan.c
> > dmi_scan.c: In function `exploding_pnp_bios':
> > dmi_scan.c:521: error: `BROKEN_PNP_BIOS' undeclared (first use in this
> > function) dmi_scan.c:521: error: (Each undeclared identifier is reported
> > only once dmi_scan.c:521: error: for each function it appears in.)
> > dmi_scan.c: In function `dmi_decode':
> > dmi_scan.c:944: warning: unused variable `data'
>
> Marcelo hasn't yet applied all the changes I sent him, including some
> that depend on each other. Just pull that change from -ac or wait

I didn't need to wait long - thanks!

D.
