Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTFYX0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTFYX0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:26:51 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:50338 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S265182AbTFYXYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:24:44 -0400
Date: Wed, 25 Jun 2003 16:35:02 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Edward Tandi <ed@efix.biz>
cc: Timothy Miller <miller@techsource.com>,
       joe briggs <jbriggs@briggsmedia.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466
In-Reply-To: <1056583075.31265.22.camel@wires.home.biz>
Message-ID: <Pine.LNX.4.44.0306251627050.19135-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

registers simply buffer the address and control signals going to and from
a module. On server boards the issue has more to do with trace length and
electrical loading than anything else... One of the issues you encounter
on server boards more than elsewere is larger more complicated memory
modules things like 36 chip double stack ecc 1 and 2gb dimms, or a large 
number of dimm modules overall (like 4-8 slots rather than 1-4).

joelja

On 26 Jun 2003, Edward Tandi wrote:
> 
> The point I was trying to make is that the registers are there to deal
> with an SMP race condition of some sort. Athlon MP motherboards fitted
> with two processors will not work properly without 'registered' RAM. I
> have hard experience of this and it this experience I am sharing with
> someone who is seeing the same symptoms.
> 
> Ed-T.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


