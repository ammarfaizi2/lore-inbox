Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRKRV4V>; Sun, 18 Nov 2001 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280132AbRKRV4C>; Sun, 18 Nov 2001 16:56:02 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:57583 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S281458AbRKRVzn>;
	Sun, 18 Nov 2001 16:55:43 -0500
Date: Sun, 18 Nov 2001 16:55:41 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <3BF82B1E.8090305@fugmann.dhs.org>
Message-ID: <Pine.SGI.4.31L.02.0111181650580.12243284-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Anders Peter Fugmann wrote:

> Hmm. It seems that these machines are in fact not identical.
> I would strongly suggest that you try to boot either one with another
> kernel, and see how it reacts.
>
> (if labrat6 is still fast using a 2.4 kernel, or if labrat5 is still
> slow with a 2.2 kernel, you have successfully shown a hardware/BIOS
> differnce between the two machines.)

labrat5+linux2.2.19 = decent response times
labrat6+linux2.2.19 = decent response times
firewall system + linux2.2.19 = decent response time

labrat5+linux2.4.x, where X=4,7,12 = painfully slow
labrat6+linux2.4.x, where X=4,7,12 = painfully slow
firewall system + linux2.4.x, where X=7 = painfully slow

> Another idea could be not to compile in SIS support.
> It might be that the driver is broken. The 2.2 kernel does not have
> support for the chipset, and uses general drivers instead. That should
> explain why throughput is higher in 2.4 kernel.

I'll try it. I just may reboot into 2.2.19, so that the compiles won't
take until kernel 2.6.2 is out. :/

I'm also thinking of calling up the hardware vendor and suggesting that
these boards be used for target practise, as the Intel 810 boards that
they were _supposed_ to replace appear to be superior.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

