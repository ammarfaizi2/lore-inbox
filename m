Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSHOLW7>; Thu, 15 Aug 2002 07:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSHOLW7>; Thu, 15 Aug 2002 07:22:59 -0400
Received: from dsl-213-023-043-164.arcor-ip.net ([213.23.43.164]:18116 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316770AbSHOLW7>;
	Thu, 15 Aug 2002 07:22:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Date: Thu, 15 Aug 2002 13:28:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Andrew Rodland <arodland@noln.com>,
       Stas Sergeev <stssppnn@yahoo.com>, linux-kernel@vger.kernel.org
References: <3D5A8C2C.9010700@yahoo.com> <E17fI5E-0002at-00@starship> <1029409051.29816.1.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1029409051.29816.1.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17fInL-0002b6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 August 2002 12:57, Alan Cox wrote:
> There are easier equivalent ways to accurately measure the IRQ
> behaviour. Flip the state of a parallel port pin when you mask
> interrupts. You can even slap an oscilloscope on it that way

Right, I'll just go get my oscilloscope now...

In fact I relied on the technique you mentioned a great deal when
I was doing realtime work with PCs.  With a multi-trace digital
scope the effect is something like a poor-man's logic analyser
with a resolution of 10 us or so.

Another technique I can recommend highly is panicking by halting
in a tight loop with the speaker set to emit some tone.  It may
be annoying for the guy at the next bench but in some code, such
as transitioning to/from virtual86 mode, there aren't a lot of
alternatives.

-- 
Daniel
