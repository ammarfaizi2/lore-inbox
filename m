Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265750AbSKAU30>; Fri, 1 Nov 2002 15:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265747AbSKAU30>; Fri, 1 Nov 2002 15:29:26 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:7437 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265750AbSKAU3X>; Fri, 1 Nov 2002 15:29:23 -0500
Date: Fri, 1 Nov 2002 21:35:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
In-Reply-To: <20021101193112.B26989@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211012119290.6949-100000@serv>
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021101125226.B16919@flint.arm.linux.org.uk>
 <Pine.LNX.4.44.0211011439420.6949-100000@serv> <20021101193112.B26989@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 1 Nov 2002, Russell King wrote:

> Ok, next problem.
> 
> A "hex" config entry under the old config language used to omit the "0x"
> prefix, requiring it to be added by whatever used it.  Kconfig adds the
> "0x" prefix, thereby causing errors.
> 
> Is this difference intentional?

No, but looking at it, I think it's better to fix the few users and to 
keep it common instead. Is there anything that needs the numbers without 
the prefix?

bye, Roman

