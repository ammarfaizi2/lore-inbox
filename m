Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSHGXYb>; Wed, 7 Aug 2002 19:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSHGXYb>; Wed, 7 Aug 2002 19:24:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48400 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316582AbSHGXYb>; Wed, 7 Aug 2002 19:24:31 -0400
Date: Wed, 7 Aug 2002 19:08:06 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>, nick.orlov@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <1028720492.18130.251.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1020807190543.14463E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Aug 2002, Alan Cox wrote:

> That would ensure the southbridge IDE stayed in one place. Another
> alternative is to enumerate all the IDE devices by class (we can do that
> nice and easy, with a little tweak for the fasttrak stuff) then hand
> them off according to the enumeration position. That would preserve the
> old semantics nicely for pci IDE. (Plug in ISA IDE is pretty rare and
> since we can't probe those its kind of hard to do anything much about
> it).

ISA my foot, real men went to the VESA bus as soon as it came out, to get
32 bit i/o. I have a 486 router, with 2.4.9 or so, maybe I should refresh
my memory as to what hardware lives there. Last install moderately recent,
it had the new bind and I had to convert all the files.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

