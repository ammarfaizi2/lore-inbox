Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319591AbSIMJmW>; Fri, 13 Sep 2002 05:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319592AbSIMJmW>; Fri, 13 Sep 2002 05:42:22 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:50579 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319591AbSIMJmV>;
	Fri, 13 Sep 2002 05:42:21 -0400
Date: Fri, 13 Sep 2002 11:46:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, vojtech@suse.cz,
       kernel@street-vision.com, linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX DMA lockup (partly solved)
Message-ID: <20020913114621.A28946@ucw.cz>
References: <20020912161258.A9056@fi.muni.cz> <200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua> <20020912211452.C29717@fi.muni.cz> <1031863392.2902.113.camel@irongate.swansea.linux.org.uk> <20020913114149.I29717@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020913114149.I29717@fi.muni.cz>; from kas@informatics.muni.cz on Fri, Sep 13, 2002 at 11:41:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 11:41:49AM +0200, Jan Kasprzak wrote:

> Vojtech Pavlik wrote:
> : 
> : X33? X33 doesn't make sense.
> : 
> 	X34, sorry. DMA 33.

Still not right. -X34 is MWDMA16, for UDMA33 you need -X66.
I know it's confusing, but these are mode numbers from the ATA spec.

-- 
Vojtech Pavlik
SuSE Labs
