Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265837AbSKBABG>; Fri, 1 Nov 2002 19:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265839AbSKBABG>; Fri, 1 Nov 2002 19:01:06 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:17069 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265837AbSKBABF>; Fri, 1 Nov 2002 19:01:05 -0500
Date: Fri, 1 Nov 2002 17:07:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
Message-ID: <20021102000730.GB6410@opus.bloom.county>
References: <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021101125226.B16919@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211011439420.6949-100000@serv> <20021101193112.B26989@flint.arm.linux.org.uk> <20021101203033.GA5773@opus.bloom.county> <20021101203546.C26989@flint.arm.linux.org.uk> <20021101204225.GA6003@opus.bloom.county> <20021101204643.D26989@flint.arm.linux.org.uk> <20021101233250.GA6410@opus.bloom.county> <Pine.LNX.4.44.0211020051090.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211020051090.6949-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 12:52:05AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Fri, 1 Nov 2002, Tom Rini wrote:
> 
> > I want both of these statements to be legal:
> > 
> > config HEXVAL_B
> > 	hex
> > 	depends on BAZ
> > 	default "0x12345678UL"
> 
> Why?

Consistency with values?  It's not needed, but in somplaces we had:
#define FOO 0x12345678UL,
which was replaced with
#define FOO CONFIG_BAR_VALUE

So for consistency (and only that really, so if it's hard just say No)
I'd like to be able to put back the 'UL' / 'L'

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
