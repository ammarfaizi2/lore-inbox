Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273590AbRIUPuJ>; Fri, 21 Sep 2001 11:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRIUPtx>; Fri, 21 Sep 2001 11:49:53 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:50099 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S273584AbRIUPtk>; Fri, 21 Sep 2001 11:49:40 -0400
Date: Fri, 21 Sep 2001 17:49:55 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010921174955.D16173@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <3E975341CB7@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E975341CB7@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.22i
X-Operating-System: vega Linux 2.4.9 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW ...
When I switched to Duron with a new (well, it was my friend's) motherboard
(according to lspci: 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)),
I can't boot Linux anymore since it stucked around partiotion checking (sorry
I don't remember, but I can check on the next week). It was kernel 2.2.19.
2.4.x works without any problem, the last kernel I've checked (and using now)
is 2.4.9. Is it the same problem?


On Wed, Sep 19, 2001 at 04:59:09PM +0000, Petr Vandrovec wrote:
> On 19 Sep 01 at 17:31, Liakakis Kostas wrote:
> > 
> > It seems to fix the stability problem. We don;t know why, but
> > experimetation shows that those _with_ the problem are relieved. This is
> > fine! We are happy with it.
> > 
> > We write to a register marked as "don't write" by Via. This is potentialy 
> > dangerous in ways we don't know yet.
> 
> Just small question - you are saying that your KT133A works fine with
> 0x89... Two questions then - Do you have more than 256MB in your box?
> And second one: Do you have one, two, or three memory modules installed
> on the board? 
> 
> If your answer is <=256MB, one module, no surprise then, as AFAIK nobody 
> with such config suffers from the problem. But checking also number of 
> memory modules looks more like black magic that anything else. 
> Hopefully VIA will answer...
>                                             Thanks,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>                                                 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
