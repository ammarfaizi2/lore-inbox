Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281587AbRK0RBx>; Tue, 27 Nov 2001 12:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRK0RBo>; Tue, 27 Nov 2001 12:01:44 -0500
Received: from getafix.lostland.net ([216.29.29.44]:60577 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S281648AbRK0RBc> convert rfc822-to-8bit; Tue, 27 Nov 2001 12:01:32 -0500
Date: Tue, 27 Nov 2001 12:01:13 -0500 (EST)
From: lk@getafix.lostland.net
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'spurious 8259A interrupt: IRQ7'
In-Reply-To: <3C03B890.29FDC654@loewe-komp.de>
Message-ID: <Pine.BSO.4.40.0111271126400.15381-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I recently enabled UP IOAPIC, and only then did I start seeing this
message.  No hardware changes.

via 82c686 with a 3com 905b.

Seems to only pop up with apic (just recompiled without it and haven't
gotten the message again).


Regards,
Adrian



On Tue, 27 Nov 2001, Peter [iso-8859-1] Wächtler wrote:

> "Martin A. Brooks" schrieb:
> >
> > > As far as I remember this was talked about earlier. Different mobos,
> > > chipsets, processor brands, but always IRQ 7. /me wonders.
> >
> > In my research before posting, a common thread seemed to be the presence of
> > a tulip card in the machine.  Has anyone seen this on a non-tulip box?
> >
>
> Yes. dmfe.o (Davicom "almost" 2114x)
>
> Athlon with VIA82686_A_. Perhaps it's the Southbridge ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


