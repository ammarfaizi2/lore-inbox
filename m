Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbSITTvr>; Fri, 20 Sep 2002 15:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbSITTvr>; Fri, 20 Sep 2002 15:51:47 -0400
Received: from ns.ithnet.com ([217.64.64.10]:44037 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S263405AbSITTvq>;
	Fri, 20 Sep 2002 15:51:46 -0400
Date: Fri, 20 Sep 2002 21:56:37 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Phil Brutsche <phil@tux.obix.com>
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, 2.4.20pre7, problem with aic7xxx driver
Message-Id: <20020920215637.224d20e8.skraw@ithnet.com>
In-Reply-To: <3D8B7BA8.8010403@tux.obix.com>
References: <20020920052832.GH41965@niksula.cs.hut.fi>
	<1184680000.1032536231@aslan.scsiguy.com>
	<20020920201919.3009507f.skraw@ithnet.com>
	<3D8B7BA8.8010403@tux.obix.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002 14:48:56 -0500
Phil Brutsche <phil@tux.obix.com> wrote:

> Stephan von Krawczynski wrote:
> > Hello Justin, hello all,
> > 
> > I just came across an interesting phenomenon regarding 2.4.19 / 2.4.20-pre7
> > and adaptec scsi. Scene is this:
> > 
> > board: Asus SP97-V with Pentium 200 (non-MMX) (I know it is old)
> > controllers tried: adaptec 29160, 29160N, 2940 U2W
> > kernel: 2.4.18-SuSE (distribution 8.0), 2.4.19, 2.4.20-pre7
> > 
> > From all possible configurations of the above the following work:
> > 
> > kernel 2.4.18-SuSE: with all controllers
> > kernel 2.4.19     : only with 2940 U2W
> > kernel 2.4.20-pre7: only with 2040 U2W

Uh, here is a typo, it should be "2940 U2W" of course ...

> The aic7xxx driver works like a champ here in 2.4.17 (vanilla and with 
> rmap-11c), vanilla 2.4.19, and early vanilla 2.5.x (last I used was 2.5.9).
> 
> This is a 29160 (the 64-bit dual-channel card, not the 19160 or 29160N) 
> controller on a MSI 694D-Pro motherboard - dual 1GHz PIIIs.

I know this.
I use it myself in quite a number of boards (all comparably new). The thing is:
why doesn't it work in an _old_ board like SP97-V, and _only_ regarding 2.4.19
/ 2.4.20-pre7 (I did not try all in between, but I dare a good guess ;-)

Regards,
Stephan

