Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276305AbRJHSYK>; Mon, 8 Oct 2001 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276302AbRJHSYB>; Mon, 8 Oct 2001 14:24:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:36811 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276231AbRJHSXt>; Mon, 8 Oct 2001 14:23:49 -0400
Date: Mon, 08 Oct 2001 11:20:59 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: landley@trommello.org, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
Message-ID: <1812679136.1002540059@mbligh.des.sequent.com>
In-Reply-To: <E15qeqz-0001Ne-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > speculate on how the 2.4.10 vm works anyway
>> 
>> Can you describe why it's N! ? Are you talking about the worst possible case, 
>> or a two level local / non-local problem?
> 
> Worst possible. I dont think in reality it will be nearly that bad

The worst possible case I can conceive (in the future architectures 
that I know of)  is 4 different levels. I don't think the number of access
speed levels is ever related to the number of processors ?
(users of other NUMA architectures feel free to slap me at this point).

So I *think* the worst possible case is still linear (to number of nodes) 
in terms of how many classzone type things we'd need? And the number 
of classzone type things any given access would have to search through 
for an access is constant? The number of zones searched would be
(worst case) linear to number of nodes?

As we're intending to code this real soon now, this is more than just idle
speculation for my own amusement ;-)

Thanks,

Martin.


