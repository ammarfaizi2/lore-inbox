Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRBJBE7>; Fri, 9 Feb 2001 20:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130601AbRBJBEt>; Fri, 9 Feb 2001 20:04:49 -0500
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:9225 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S130399AbRBJBEn>; Fri, 9 Feb 2001 20:04:43 -0500
Message-ID: <3A849331.8D53C571@damncats.org>
Date: Fri, 09 Feb 2001 20:02:41 -0500
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mucho timeouts on USB
In-Reply-To: <3A8489DE.D8C2B80A@damncats.org> <20010209165309.S10691@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Fri, Feb 09, 2001 at 07:22:54PM -0500, John Cavan wrote:
> >
> > Current config:
> >
> > Dual P3-500 w/ 512mb of RAM
> > Tyan Tiger 133 mobo with VIA chipset, onboard USB
> > Kernel 2.4.1-ac9 compiled with egcs-1.1.2
> 
> This motherboard does not currently work with USB in SMP mode, unless
> you boot with "noapic" on the command line.  People are working on it,
> but it's slow going.

I'll try that.

> FWIW, Windows2000 refuses to also work for this VIA USB chipset :)

According to Tyan, the issue should be fixed with the last BIOS update.
I'm up to date in the BIOS (and I really wish that these guys would
create a flash program that was OSS so I could avoid DOS), but one of
the work arounds suggested was setting IRQ 12 to ISA/Legacy for Windows
2000. Didn't seem to cut it.

Thanks,
John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
