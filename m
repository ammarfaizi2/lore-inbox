Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSE2Rk7>; Wed, 29 May 2002 13:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSE2Rk6>; Wed, 29 May 2002 13:40:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:4600 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314340AbSE2Rkz>; Wed, 29 May 2002 13:40:55 -0400
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020529190135.A19776@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 19:43:37 +0100
Message-Id: <1022697817.12888.275.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 18:01, Vojtech Pavlik wrote:
> The early drives haven't changed, but the drivers for the controllers
> which they were tested on changed (or will change soon). Namely the
> lists of PIO mode limits were wrong very often. This is mainly because
> some of the (now almost unused) drivers program the timings incorrectly
> into the controller registers.

Ok I'm not sure on the PIO ones. The DMA blacklist is a set of devices
that had actual firmware side problems on the whole and vendor confirmed
ones.
 
> I can't say much about the more recent entries, except for that it'd be
> nice to add a date when the entry was last tested and with what result
> to each of them over time.

The ones I have are from vendors whom I hope know what they are doing.
The one exception is an item which is missing which is the needed
blacklist of UDMA on the OSB4 for one vendor at least (MWDMA is fine)

