Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130892AbRBJBpr>; Fri, 9 Feb 2001 20:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRBJBph>; Fri, 9 Feb 2001 20:45:37 -0500
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:13577 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S131048AbRBJBpW>; Fri, 9 Feb 2001 20:45:22 -0500
Message-ID: <3A849CB6.C8EF4345@damncats.org>
Date: Fri, 09 Feb 2001 20:43:18 -0500
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mucho timeouts on USB
In-Reply-To: <3A8489DE.D8C2B80A@damncats.org> <20010209165309.S10691@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

That did the trick! Thanks alot.

Nice too, first song played by Rush. :o)

John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
