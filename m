Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSKZXML>; Tue, 26 Nov 2002 18:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSKZXML>; Tue, 26 Nov 2002 18:12:11 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49555 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261842AbSKZXML>; Tue, 26 Nov 2002 18:12:11 -0500
Subject: Re: =?ISO-8859-1?Q?RE=C2=A0:?= Clock is suddently ticking too fast ! 
	[Kernel2.4.19-pre10-ac2, Intel]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benoit GRANGE <Benoit.GRANGE@fr.tiscali.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <8B5E8461FFB6B44F85E3504A81AF3D9117616C@frparex01.fr.tiscali.com>
References: <8B5E8461FFB6B44F85E3504A81AF3D9117616C@frparex01.fr.tiscali.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 23:50:38 +0000
Message-Id: <1038354638.2534.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 20:22, Benoit GRANGE wrote:
> Alan Said:
> > Does this stop if you boot with "noapic" 
> I will try, but the clock frenzy happens only once every full moon...
> it won't be easy to tell.
> By the way, can you refer me to some nice documents explaining what is apic ?
> Regards,
> Benoit Grange

Old IBM PC has PIC (peripheral interrupt controller) - does the 16 IRQ
lines and attaches them to the CPU

Modern PC also as APIC (advanced peripheral interrupt controller) which
is in two parts - locsl apic is on the CPU, and talks over a link to one
or more io-apics that attach to the devices on the bus

"noapic" says to run the box like an old IBM PC

