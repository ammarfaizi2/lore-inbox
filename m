Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSFUSX3>; Fri, 21 Jun 2002 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSFUSX2>; Fri, 21 Jun 2002 14:23:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1691 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316728AbSFUSX1>;
	Fri, 21 Jun 2002 14:23:27 -0400
Date: Fri, 21 Jun 2002 11:18:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.x: arch/i386/kernel/cpu
In-Reply-To: <aeouoe$a66$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0206211116590.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jun 2002, H. Peter Anvin wrote:

> Whomever broke up arch/i386/kernel/setup.c and created the CPU
> directory (very good idea) messed up in at least one place:

Ah! I just noticed this (as I was cleaning out my inbox before I head off 
to Canada). 

> The *AMD-defined* CPUID flags (0x80000001) are not just used on AMD
> processors!  In fact, at least AMD, Transmeta, Cyrix and VIA all use
> them; I don't know about Centaur or Rise.  Intel supports the actual
> level starting with the P4 although it returns all zero.
> 
> It should, in my opinion, be moved into generic_identify().  Anyone
> who has a reason why that shouldn't be done speak now or I'll send the
> patch to Linus.

If you've already sent it, good. If not, and you have something readily 
available, good. If not, I'll add it to my short list and look at it in 
the next few days (hopefully).

Thanks,

	-pat

