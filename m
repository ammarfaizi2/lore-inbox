Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSKZXW5>; Tue, 26 Nov 2002 18:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKZXW5>; Tue, 26 Nov 2002 18:22:57 -0500
Received: from fmr06.intel.com ([134.134.136.7]:4576 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262905AbSKZXW5>; Tue, 26 Nov 2002 18:22:57 -0500
Message-ID: <010201c295a3$c24d5110$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Benoit GRANGE" <Benoit.GRANGE@fr.tiscali.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <8B5E8461FFB6B44F85E3504A81AF3D9117616C@frparex01.fr.tiscali.com> <1038354638.2534.76.camel@irongate.swansea.linux.org.uk>
Subject: =?iso-8859-1?Q?Re:_RE=C2=A0:_Clock_is_suddently_ticking_too_fast_!_=5BKer?=
	=?iso-8859-1?Q?nel2.4.19-pre10-ac2=2C_Intel=5D?=
Date: Tue, 26 Nov 2002 15:30:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2002-11-26 at 20:22, Benoit GRANGE wrote:
> > Alan Said:
> > > Does this stop if you boot with "noapic"
> > I will try, but the clock frenzy happens only once every full moon...
> > it won't be easy to tell.
> > By the way, can you refer me to some nice documents explaining what is
apic ?
> > Regards,
> > Benoit Grange
>

There is also the "Multiprocessor Specification" that talks about APIC.
You can get to the document from:
http://www.intel.com/design/pentium/datashts/242016.htm

> Old IBM PC has PIC (peripheral interrupt controller) - does the 16 IRQ
> lines and attaches them to the CPU
>
> Modern PC also as APIC (advanced peripheral interrupt controller) which
> is in two parts - locsl apic is on the CPU, and talks over a link to one
> or more io-apics that attach to the devices on the bus
>
> "noapic" says to run the box like an old IBM PC
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

