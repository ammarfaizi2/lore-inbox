Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277127AbRJDExJ>; Thu, 4 Oct 2001 00:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277126AbRJDExA>; Thu, 4 Oct 2001 00:53:00 -0400
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:64773 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S277127AbRJDEwt>;
	Thu, 4 Oct 2001 00:52:49 -0400
Date: Thu, 4 Oct 2001 01:53:16 -0300
From: =?us-ascii?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Michel =?us-ascii?Q?D=E4nzer?= <daenzer@debian.org>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
Subject: Re: Panic on PowerPC
Message-ID: <20011004015316.A1082@iname.com>
Mail-Followup-To: Michel =?us-ascii?Q?D=E4nzer?= <daenzer@debian.org>,
	linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
In-Reply-To: <20011003222219.A487@iname.com> <1002159607.2363.16.camel@pismo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <1002159607.2363.16.camel@pismo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04 2001, Michel Dänzer wrote:
> On Thu, 2001-10-04 at 03:22, =?us-ascii?Q?Rog=E9rio?= Brito wrote:
> 
> > >>NIP; c0005d58 <__sti+8/50>   <=====
> > Trace; c01758c8 <rtc_init+b8/16c>
> > Trace; c016576c <do_initcalls+30/50>
> > Trace; c01657b8 <do_basic_setup+2c/3c>
> > Trace; c00038a4 <init+14/1b0>
> > Trace; c00062a4 <kernel_thread+34/40>
> 
> Disable CONFIG_RTC, only enable CONFIG_PPC_RTC in the kernel config.

	Thank you very much, Michel.

	That was it. I recompiled the kernel and it worked fine. I
	guess that that was my first traps of the PPC platform. :-)

	OTOH, just to document this on the archives, now that I can
	run a 2.4 kernel, the IMS TT card is showing up in lspci.


	Thanks you very much, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
