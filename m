Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265813AbSKAX01>; Fri, 1 Nov 2002 18:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265817AbSKAX01>; Fri, 1 Nov 2002 18:26:27 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:8877 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265813AbSKAX00>; Fri, 1 Nov 2002 18:26:26 -0500
Date: Fri, 1 Nov 2002 16:32:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
Message-ID: <20021101233250.GA6410@opus.bloom.county>
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021101125226.B16919@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211011439420.6949-100000@serv> <20021101193112.B26989@flint.arm.linux.org.uk> <20021101203033.GA5773@opus.bloom.county> <20021101203546.C26989@flint.arm.linux.org.uk> <20021101204225.GA6003@opus.bloom.county> <20021101204643.D26989@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101204643.D26989@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 08:46:43PM +0000, Russell King wrote:
> On Fri, Nov 01, 2002 at 01:42:25PM -0700, Tom Rini wrote:
> > On Fri, Nov 01, 2002 at 08:35:46PM +0000, Russell King wrote:
> > > On Fri, Nov 01, 2002 at 01:30:33PM -0700, Tom Rini wrote:
> > > > On a related question, can we now have 'UL', etc in a hex statement /
> > > > question?
> > > 
> > > No thanks - that'll stop it being used in linker scripts.
> > 
> > How, if it's not used for a value which a linker script cares about?
> 
> Hmm, maybe I'm misunderstanding you.  Where do you want "UL" to appear
> in relation to a "hex" statement?

I want both of these statements to be legal:

config HEXVAL_A
	hex
	depends on FOO || BAR
	default "0x12345678"

config HEXVAL_B
	hex
	depends on BAZ
	default "0x12345678UL"

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
