Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263602AbREYHF3>; Fri, 25 May 2001 03:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263604AbREYHFT>; Fri, 25 May 2001 03:05:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13262 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263602AbREYHFB>;
	Fri, 25 May 2001 03:05:01 -0400
Date: Fri, 25 May 2001 03:05:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Jaeger <aj@suse.de>
cc: Aaron Lehmann <aaronl@vitelus.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <u8r8xd3o9i.fsf@gromit.moeb>
Message-ID: <Pine.GSO.4.21.0105250303170.24864-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 May 2001, Andreas Jaeger wrote:

> We have comments in the code that state how j0 is build, and R0/S0
> come from some expansion:
>  * Bessel function of the first and second kinds of order zero.
>  * Method -- j0(x):
>  *	1. For tiny x, we use j0(x) = 1 - x^2/4 + x^4/64 - ...
>  *	2. Reduce x to |x| since j0(x)=j0(-x),  and
>  *	   for x in (0,2)
>  *		j0(x) = 1-z/4+ z^2*R0/S0,  where z = x*x;
>  *	   (precision:  |j0-1+z/4-z^2R0/S0 |<2**-63.67 )
> 
> Andreas

Sure. However, the question about choosing the polynomials stands.
(And no, I'm not proposing to go and bugger glibc folks over that ;-)

