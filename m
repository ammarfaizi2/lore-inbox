Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSHHK3A>; Thu, 8 Aug 2002 06:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSHHK27>; Thu, 8 Aug 2002 06:28:59 -0400
Received: from [196.26.86.1] ([196.26.86.1]:2771 "EHLO
	infosat-gw.realnet.co.sz") by vger.kernel.org with ESMTP
	id <S317421AbSHHK27>; Thu, 8 Aug 2002 06:28:59 -0400
Date: Thu, 8 Aug 2002 12:49:32 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Adam J. Richter" <adam@yggdrasil.com>, <nick.orlov@mail.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <Pine.LNX.3.96.1020807190543.14463E-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0208081246110.24255-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Bill Davidsen wrote:

> On 7 Aug 2002, Alan Cox wrote:
> 
> > That would ensure the southbridge IDE stayed in one place. Another
> > alternative is to enumerate all the IDE devices by class (we can do that
> > nice and easy, with a little tweak for the fasttrak stuff) then hand
> > them off according to the enumeration position. That would preserve the
> > old semantics nicely for pci IDE. (Plug in ISA IDE is pretty rare and
> > since we can't probe those its kind of hard to do anything much about
> > it).

Well there is also the ISAPNP IDE plug in variant, or would these qualify 
as 'pci' in terms of enumeration? The devices i'm thinking about are the 
ones on ISAPNP sound cards.

	Zwane

-- 
function.linuxpower.ca

