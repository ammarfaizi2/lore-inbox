Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSHLNce>; Mon, 12 Aug 2002 09:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSHLNce>; Mon, 12 Aug 2002 09:32:34 -0400
Received: from smtp03.web.de ([217.72.192.158]:37154 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S317997AbSHLNcd>;
	Mon, 12 Aug 2002 09:32:33 -0400
Date: Mon, 12 Aug 2002 10:51:32 +0200
From: Lars Ellenberg <lglnberg@rz.uni-potsdam.de>
To: linux-kernel@vger.kernel.org
Subject: Re: via vp3 udma corruption
Message-ID: <20020812105132.C654@johann>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020811210826.GA684@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811210826.GA684@spacedout.fries.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 04:08:26PM -0500, David Fries wrote:
> I started on 2.4.19 testing a CD-ROM with the ide-scsi driver.  It
> gave errors with UDMA enabled.  Many hours later I decided my
> harddrive is silently flipping a bit every once and a while on read!

yes, known issue -- to me, at least. had this on a similar VIA board
last year. happens all the time you have high DMA load. bios update
fixed it for me (or at least reduced the frequency so I did not notice
it any longer). I do not know whether it will fix it for you, maybe they
have screwed up differently this time :)

> Why wouldn't the harddrive report CRC errors?

hm, because it reads ok, and the bitflip is done by the broken DMA
lateron?

> I don't see any errors with UDMA disabled on both the hard drive and
> CDROM.
> 
>     Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
>     PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
>     ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 65).
>     IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
Cheers,
 Lars-Gunnar
