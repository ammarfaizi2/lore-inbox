Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262090AbRENOcL>; Mon, 14 May 2001 10:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262105AbRENOcB>; Mon, 14 May 2001 10:32:01 -0400
Received: from tux.gsfc.nasa.gov ([128.183.191.134]:1177 "EHLO
	tux.gsfc.nasa.gov") by vger.kernel.org with ESMTP
	id <S262090AbRENObt>; Mon, 14 May 2001 10:31:49 -0400
Date: Mon, 14 May 2001 10:31:48 -0400
From: John Kodis <kodis@mail630.gsfc.nasa.gov>
To: linux-kernel@vger.kernel.org
Subject: Re: Not a typewriter
Message-ID: <20010514103148.B9532@tux.gsfc.nasa.gov>
Mail-Followup-To: John Kodis <kodis@mail630.gsfc.nasa.gov>,
	linux-kernel@vger.kernel.org
In-Reply-To: <mharris@opensourceadvocate.org> <200105140103.f4E13U3r010249@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105140103.f4E13U3r010249@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, May 13, 2001 at 09:03:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 09:03:30PM -0400, Horst von Brand wrote:

> The old C compiler/old Unix linker guaranteed 6 chars in an external symbol
> name only, and C functions got an underscore prepended: _creat. I guess
> this is the reason for this wart. As to why 6 chars only, I'd guess some
> data structure in the linker was laid out that way. Machines had a few
> dozen Kbs of RAM then, space was precious.

I recall that RSX-11 and a few other series of early DEC operating
systems stored linker symbols in a "RAD50" encoding scheme which
allowed 6 chararacters to be crammed into a 32-bit "long word".  I
suspect that this is where the limitation originated.

-- 
John Kodis <kodis@acm.org>
Phone: 301-286-7376
