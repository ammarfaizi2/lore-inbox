Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129095AbRBANiB>; Thu, 1 Feb 2001 08:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbRBANhv>; Thu, 1 Feb 2001 08:37:51 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:41734 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129095AbRBANhg>; Thu, 1 Feb 2001 08:37:36 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: mjacob@feral.com, dank@alumni.caltech.edu
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E6.0049DA68.00@d73mta05.au.ibm.com>
Date: Thu, 1 Feb 2001 18:50:08 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sct wrote:
>> >
>> > Thanks for mentioning this. I didn't know about it earlier. I've been
>> > going through the 4/00 kqueue patch on freebsd ...
>>
>> Linus has already denounced them as massively over-engineered...
>
>That shouldn't stop anyone from looking at them and learning, though.
>There might be a good idea or two hiding in there somewhere.
>- Dan
>

There is always a scope to learn from a different approach to tackle a
problem of a similar nature -  both good ideas as well as over-engineered
ones - sometimes more from the later :-)

As far as I have understood so far from looking at the original kevent
patch and notes (which perhaps isn't enough and maybe out of date as well),
the concept of knotes and filter ops, and the event queuing mechanism in
itself is interesting and generic, but most of it seems to have been
designed with linkage to user-mode issueable event waits in mind - like
poll/select/aio/signal etc, at least as it appears from the way its been
used in the kernel. A little different from what I had in mind, though its
perhaps possible to use it otherwise. But maybe I've just not thought about
it enough or understood it.

Regards
Suparna

  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
