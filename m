Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265761AbSKBAjy>; Fri, 1 Nov 2002 19:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265783AbSKBAjy>; Fri, 1 Nov 2002 19:39:54 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:46089 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265761AbSKBAjx>; Fri, 1 Nov 2002 19:39:53 -0500
Date: Sat, 2 Nov 2002 01:46:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
In-Reply-To: <20021102000730.GB6410@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0211020119520.6949-100000@serv>
References: <Pine.LNX.4.44.0210311452531.13258-100000@serv>
 <20021101125226.B16919@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211011439420.6949-100000@serv>
 <20021101193112.B26989@flint.arm.linux.org.uk> <20021101203033.GA5773@opus.bloom.county>
 <20021101203546.C26989@flint.arm.linux.org.uk> <20021101204225.GA6003@opus.bloom.county>
 <20021101204643.D26989@flint.arm.linux.org.uk> <20021101233250.GA6410@opus.bloom.county>
 <Pine.LNX.4.44.0211020051090.6949-100000@serv> <20021102000730.GB6410@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 1 Nov 2002, Tom Rini wrote:

> Consistency with values?  It's not needed, but in somplaces we had:
> #define FOO 0x12345678UL,
> which was replaced with
> #define FOO CONFIG_BAR_VALUE
> 
> So for consistency (and only that really, so if it's hard just say No)
> I'd like to be able to put back the 'UL' / 'L'

It would add more complexity than it gives us it. I would implement it if 
it would help avoiding helping complexity somewhere else.

bye, Roman

