Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290118AbSAQWGY>; Thu, 17 Jan 2002 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290481AbSAQWGO>; Thu, 17 Jan 2002 17:06:14 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:34312 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S290118AbSAQWGH>; Thu, 17 Jan 2002 17:06:07 -0500
Subject: Re: hangs using opengl
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: J Sloan <jjs@lexus.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C47429B.7060306@lexus.com>
In-Reply-To: <20020117191450.932B64ADB4@drie.kotnet.org>		<3C47284A.9080607@kabelfoon.nl>
	 <1011300289.32057.18.camel@zeus> 	<3C473A57.3000206@lexus.com>
	<1011302680.639.12.camel@zeus>  <3C47429B.7060306@lexus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 16:04:17 -0600
Message-Id: <1011305059.614.31.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 15:31, J Sloan wrote:
> >Stability wise,
> >internal NvAGP worked better than agpgart on KX133 and 440BX.
> >
> OK - I am seeing no stability issues so
> I guess I don't have to worry about that
> bit -

Interesting, as I said before, YMMV. On this system (cheap Korean
mainboard), a previous BIOS rev completely hosed AGP altogether :-/.

> 
> BTW I did notice some longish pauses
> during RtCW when using nv agp, so I
> am using the in-kernel agp....

Hmm, it's fine here. What chipset and video card are you using? I've
been looking at Athlon boards and I'm curious about issues showing up in
AGP, IDE, PCI among the various platforms -- specifically AMD and Via
(maybe SiS too).

I've heard some (dis?)information that AMD agpgart lacks errata
workarounds? SiS lacks support for more than ATA66? Are there still
problems with Via timers or PCI?

Just curious,
Reid

