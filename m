Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319665AbSH3VZj>; Fri, 30 Aug 2002 17:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319666AbSH3VZj>; Fri, 30 Aug 2002 17:25:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24078 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319665AbSH3VZi>; Fri, 30 Aug 2002 17:25:38 -0400
Date: Fri, 30 Aug 2002 18:22:08 -0300
From: Sergio Bruder <sergio@bruder.net>
To: Markus Plail <plail@web.de>
Cc: Anssi Saari <as@sci.fi>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is enabled
Message-ID: <20020830212208.GA6065@bruder.net>
Reply-To: sergio@bruder.net
Mail-Followup-To: Sergio Bruder <sergio@bruder.net>,
	Markus Plail <plail@web.de>, Anssi Saari <as@sci.fi>,
	Andre Hedrick <andre@linux-ide.org>, vojtech@ucw.cz,
	linux-kernel@vger.kernel.org
References: <200204092206.02376.roger.larsson@norran.net> <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org> <20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net> <87d6s0g9eq.fsf@plailis.homelinux.net> <20020830065142.GA10582@sci.fi> <874rdcg62f.fsf@plailis.homelinux.net> <20020830154225.GA6114@sci.fi> <873cswuvvi.fsf@plailis.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cswuvvi.fsf@plailis.homelinux.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 06:58:09PM +0200, Markus Plail wrote:
> Hi Anssi!
> 
> * Anssi Saari writes:
> >On Fri, Aug 30, 2002 at 09:27:04AM +0200, Markus Plail wrote:
> >>* Anssi Saari writes:
> >>>I also don't have your DAO vs. TAO problem.
> >>
> >>Hmm.. you wrote that cdrdao gives the problem, but cdrecord doesn't.
> >
> >I doubt that. Even if I did, it's wrong.
> 
> Yes, sorry, it was Sergio.
> 
> (...)
>
> If you write CDs in RAW modes, then there's the problem with the high
> loads. Examples:
> - cdrecord -raw96r/p (2448 bytes/sector)
> - cdrecord -raw16    (2368 bytes/sector)
> - cdrdao --driver generic-mmc-raw (2368 bytes/sector)
> 
> So for Sergio: Try using the generic-mmc without raw driver in cdrdao.
>

I was using exactly generic-mmc, never tried the raw version.

I only said that with ISO images the problem dont show up, as Anssi.

> 
> And audio CDs or (S)VCDs are written in mode2 (2352 bytes/sector) and
> also cause the high loads, this time independent from the writing mode.
> AFAIK this behaviour should be the same on any Linux system.


Sergio Bruder
--
http://pontobr.org
pub  1024D/0C7D9F49 2000-05-26 Sergio Devojno Bruder <sergio@bruder.net>
     Key fingerprint = 983F DBDF FB53 FE55 87DF  71CA 6B01 5E44 0C7D 9F49
sub  1024g/138DF93D 2000-05-26
