Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265732AbSKAUYK>; Fri, 1 Nov 2002 15:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265734AbSKAUYK>; Fri, 1 Nov 2002 15:24:10 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:63148 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265732AbSKAUYJ>; Fri, 1 Nov 2002 15:24:09 -0500
Date: Fri, 1 Nov 2002 13:30:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: Where's the documentation for Kconfig?
Message-ID: <20021101203033.GA5773@opus.bloom.county>
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021101125226.B16919@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211011439420.6949-100000@serv> <20021101193112.B26989@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101193112.B26989@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 07:31:12PM +0000, Russell King wrote:
> Ok, next problem.
> 
> A "hex" config entry under the old config language used to omit the "0x"
> prefix, requiring it to be added by whatever used it.  Kconfig adds the
> "0x" prefix, thereby causing errors.
> 
> Is this difference intentional?

I would imagine so since it means you don't have to add '0x' in front of
things anymore (since IIRC define_hex would allow either previously, fun
and hilarity would ensure).

On a related question, can we now have 'UL', etc in a hex statement /
question?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
