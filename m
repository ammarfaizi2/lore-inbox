Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279790AbRK0Oeq>; Tue, 27 Nov 2001 09:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279818AbRK0OeY>; Tue, 27 Nov 2001 09:34:24 -0500
Received: from [195.66.192.167] ([195.66.192.167]:41734 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279790AbRK0OeO>; Tue, 27 Nov 2001 09:34:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Steinmetz <ast@domdv.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "spurious 8259A interrupt: IRQ7"
Date: Tue, 27 Nov 2001 16:30:29 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, <martin@jtrix.com (Martin A. Brooks)>
In-Reply-To: <XFMail.20011127152007.ast@domdv.de>
In-Reply-To: <XFMail.20011127152007.ast@domdv.de>
MIME-Version: 1.0
Message-Id: <01112716302905.00872@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 12:20, Andreas Steinmetz wrote:
> As far as I remember this was talked about earlier. Different mobos,
> chipsets, processor brands, but always IRQ 7. /me wonders. At least it
> doesn't do any harm (got this message on nearly all or all of my systems).
>
> On 27-Nov-2001 Alan Cox wrote:
> >> I get this with 2.4.16 vanilla, though. IRQ 7 appears to be unassigned
> >> according to /proc/pci.
> >>
> >> Machine is a 1ghz Athlon on a VIA VT82C686 mobo and a DEC 21140 NIC.
> >>
> >> Any pointers appreciated.
> >
> > IRQ7 is asserted when the PIC sees an interrupt but nobody appears to be
> > generating it when it looks.

I see it too on my home system (Duron 650 + VIA chipset)
--
vda
