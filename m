Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263763AbUFKJpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUFKJpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 05:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUFKJpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 05:45:43 -0400
Received: from gprs214-150.eurotel.cz ([160.218.214.150]:27008 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263763AbUFKJpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 05:45:42 -0400
Date: Fri, 11 Jun 2004 11:45:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Dealing with buggy hardware (was: b44 and 4g4g)
Message-ID: <20040611094523.GB13834@elf.ucw.cz>
References: <20040531202104.GA8301@ee.oulu.fi> <20040605200643.GA2210@ee.oulu.fi> <20040605131923.232f8950.davem@redhat.com> <20040609122905.GA12715@ee.oulu.fi> <20040610200504.GG4507@openzaurus.ucw.cz> <20040610203442.GA27762@ee.oulu.fi> <20040610211217.GA6634@elf.ucw.cz> <20040611061730.GA8081@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611061730.GA8081@ee.oulu.fi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, this is probably other problem. When the bug hit, what are the symptoms?
> Total immediate crash without an oops. When the RX ring skbufs are allocated
> with GFP_DMA receives work, but any transmits from > 1GB cause a link
> down/link up (which is just about all of them). With GPF_DMA bounce
> buffers those start working too.
> 
> > > (Or the issue isn't fully understood yet, figuring out what breaks and what
> > > doesn't was basically just trial and error :-/ )
> > 
> > Can you try the driver from broadcom? bcom4400, or how is it
> > called. Its extremely ugly, but might get this kind of stuff right...
> Tried that, it breaks with 4:4 and >1GB in exactly the same way :-)

You might want to report them, then look at diff between latest and
previous versions :-)))).
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
