Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284570AbRLUOk0>; Fri, 21 Dec 2001 09:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284246AbRLUOkG>; Fri, 21 Dec 2001 09:40:06 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:44046 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S283759AbRLUOkD>; Fri, 21 Dec 2001 09:40:03 -0500
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: Rene Engelhard <mail@rene-engelhard.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B848EEB6.406C%mail@rene-engelhard.de>
In-Reply-To: <B848EEB6.406C%mail@rene-engelhard.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Dec 2001 08:40:25 -0600
Message-Id: <1008945627.6599.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-21 at 06:50, Rene Engelhard wrote:
> >> Why? For instance a millibyte/s might be a hearbeat across a LAN every
> >> hour or so or it might be a control traffic requirement for a deep space
> >> probe. You might not have an immediate use for the term but it has a
> >> specific meaning - and certainly isn't "absurd" (see definition on
> >> http://www.dict.org).
> > 
> > So, is it 1/1024 or 1/1000 bytes ?  :-)
> 
> 1/1024. Because we are talking about byte.

What does bytes have to do with anything? Is it 
1/(2^3 * 10^7) or 1/(2^3 * 2^7)? We're talking about expressing a number
of "bytes"; terms of the base number system don't have any bearing --
and that's the problem. RAM and addressing are restricted to expressions
in terms of binary numbers, as in 2^10, 2^20, etc. Hard drive
manufacturers feel it's neccessary to express storage in terms of base
10 numbers of bytes, even though a sector is 2^9 bytes. In networking,
absolute numbers of bits on the wire are whats important. Though for
some reason telecom engineers have pinned megabit as 1,024,000 bits.
Experienced CS people can glean the proper definition from context, but
the terms should really lend themselves to accurate definition all the
time. If I just say off the cuff that I'm going to send you a megabyte
of data, do I mean 1,000,000 bytes, 1,048,576 bytes, or 1,024,000 bytes?
With the new measures those would be a megabyte, a mebibyte, and 1,024
kilobytes respectively.

Personally I feel that "kibibyte(KiB)" and "mebibyte(MiB)" are silly,
but they are technically unambiguous.

Regards,
Reid
--
"Public sentiment is everything. With public sentiment, nothing can
fail; without it nothing can succeed." -- Abraham Lincoln



> 
> Rene


