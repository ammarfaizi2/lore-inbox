Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274572AbRITR3p>; Thu, 20 Sep 2001 13:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274574AbRITR3g>; Thu, 20 Sep 2001 13:29:36 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:3735 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S274572AbRITR3Z>; Thu, 20 Sep 2001 13:29:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <DevilKin@gmx.net>
Reply-To: DevilKin@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Re: AGPGART for AMD 761 broken in 2.4.10-pre12?
Date: Thu, 20 Sep 2001 19:28:56 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <20010920171534.C26E09BB3F@pop3.telenet-ops.be>
In-Reply-To: <20010920171534.C26E09BB3F@pop3.telenet-ops.be>
X-Cats: All your linux' belong to us!
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920172940.A93A89BB3F@pop3.telenet-ops.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 September 2001 19:14, DevilKin wrote:
> Hello All,
>
> First off, I'd like to say a big 'thank you!!!!' to all the people here, I
> was very amazed at the quickness the support for the chipset was integrated
> into the maintream kernel.
>
> I've been testing the latest kernels a bit, and I've found out that when
> using the pre12 kernel, I once again get:
>
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: Unsupported AMD chipset (device id: 700e), you might want to try
> agp_try_unsupported=1.
> agpgart: no supported devices found.
>
> where as with the pre11 kernel it was:
>
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: Detected AMD 761 chipset
>
>
> I've not had the time to crosscheck what actually changed with -pre12, but
> could it be the patch got lost somewhere?
>
> Thanks,
>
> DevilKin

I've manually applied the patch written for the pre-11 kernels, and then it 
works great. Could it be it hasn't been added to pre-12?

Thanks,

DevilKin
-- 
devilkin@gmx.net
