Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSGaNLA>; Wed, 31 Jul 2002 09:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSGaNLA>; Wed, 31 Jul 2002 09:11:00 -0400
Received: from ns.suse.de ([213.95.15.193]:46855 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318349AbSGaNK7>;
	Wed, 31 Jul 2002 09:10:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: blp@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
References: <Pine.LNX.4.33.0207301433480.2051-100000@penguin.transmeta.com>
	<Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu>
	<87znw8anje.fsf@pfaff.Stanford.EDU>
	<1028122978.8510.59.camel@irongate.swansea.linux.org.uk>
X-Yow: Today, THREE WINOS from DETROIT sold me a framed photo of
 TAB HUNTER before his MAKEOVER!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 31 Jul 2002 14:57:29 +0200
In-Reply-To: <1028122978.8510.59.camel@irongate.swansea.linux.org.uk> (Alan
 Cox's message of "31 Jul 2002 14:42:58 +0100")
Message-ID: <jeu1mg3vie.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

|> On Tue, 2002-07-30 at 22:55, Ben Pfaff wrote:
|> > 1    The typedef name intN_t designates a signed integer type with
|> >      width N, no padding bits, and a two's complement
|> >      representation. Thus, int8_t denotes a signed integer type
|> >      with a width of exactly 8 bits.
|> 
|> And arbitary alignment requirements. At least I see nothing in C99
|> saying that
|> 
|> 	uint8_t foo;
|> 	uint8_t bar;
|> 
|> isnt allowed to give you interesting suprises

If it's part of a structure, then yes.  The C standard has always allowed
arbitrary padding between structure members.  It's an ABI issue.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
