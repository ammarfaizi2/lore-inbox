Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271333AbRHQUbt>; Fri, 17 Aug 2001 16:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271348AbRHQUbj>; Fri, 17 Aug 2001 16:31:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48657 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271333AbRHQUbU>; Fri, 17 Aug 2001 16:31:20 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 17 Aug 2001 21:33:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        manuel@mclure.org (Manuel McLure), linux-kernel@vger.kernel.org
In-Reply-To: <20010816232814.A38@toy.ucw.cz> from "Pavel Machek" at Aug 16, 2001 11:28:15 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XqJ1-00081w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oops while *using* the driver seem to be much less severe than random
> lockups when *NOT* using driver. According to ESR, 2.4.7 is doing the 
> latter.

And ESR is using a very early chipset with apic bugs out of the wazoo
that locks up anyway. So at the time lets say that wasnt useful data.
The 2.4.9 one seems to be better. The mixer is totally screwball but the
SMP lock seems to have gone away
