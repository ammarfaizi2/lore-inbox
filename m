Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265718AbSKFPTT>; Wed, 6 Nov 2002 10:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265717AbSKFPTT>; Wed, 6 Nov 2002 10:19:19 -0500
Received: from [212.18.235.100] ([212.18.235.100]:17930 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S265716AbSKFPTQ>; Wed, 6 Nov 2002 10:19:16 -0500
Subject: Re: promise ide problem: missing disks (RESOLVED)
From: Justin Cormack <justin@street-vision.com>
To: Brian Jackson <brian-kernel-list@mdrx.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20021106000052.21645.qmail@escalade.vistahp.com>
References: <1036525756.2291.45.camel@lotte>
	<1036539902.2291.48.camel@lotte> 
	<20021106000052.21645.qmail@escalade.vistahp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 15:25:41 +0000
Message-Id: <1036596349.5076.5.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the 0.30 Promise driver was ok (in RedHat 7.3 and 2.4.18) if it
supports the card. 0.32 is broken, this is in 2.4.19 and 20-pre. The
0.35 driver in -ac and 2.5 is fine too.

Given that, I think the bbest solution is if the driver updates in -ac
go to Marcello for 2.4.21-pre1... though it seems a pity to ship 2.4.20
with a driver that is broken.

On Wed, 2002-11-06 at 00:00, Brian Jackson wrote:
> I may be able to help you narrow it down a bit. I have used 2.4.19-vanilla 
> and it worked fine(all drives showed up). When I tried 
> fnk10(www.cipherfunk.org) the drive on the secondary channel doesn't show 
> up. I don't know exactly what changes fnk10 has with regards to ide, but I 
> know he has put a bunch of stuff from the 20-pre series in fnk10. Hope this 
> helps. 
> 
>  --Brian Jackson 
> 
> Justin Cormack writes: 
> 
> > On Tue, 2002-11-05 at 19:49, Justin Cormack wrote:
> >> I have a Promise Ultra133 IDE controller, and cannot get any drives to
> >> appear on the second channel under Linux. The controller says it finds
> >> the drive on the second channel on its bios screen, but Linux will not
> >> see it. This is with 2.4.20-pre9 and -rc1.


