Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274084AbRISO7c>; Wed, 19 Sep 2001 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274085AbRISO7X>; Wed, 19 Sep 2001 10:59:23 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:8210 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S274084AbRISO7P>;
	Wed, 19 Sep 2001 10:59:15 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Date: Wed, 19 Sep 2001 16:59:09 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <3E975341CB7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 01 at 17:31, Liakakis Kostas wrote:
> 
> It seems to fix the stability problem. We don;t know why, but
> experimetation shows that those _with_ the problem are relieved. This is
> fine! We are happy with it.
> 
> We write to a register marked as "don't write" by Via. This is potentialy 
> dangerous in ways we don't know yet.

Just small question - you are saying that your KT133A works fine with
0x89... Two questions then - Do you have more than 256MB in your box?
And second one: Do you have one, two, or three memory modules installed
on the board? 

If your answer is <=256MB, one module, no surprise then, as AFAIK nobody 
with such config suffers from the problem. But checking also number of 
memory modules looks more like black magic that anything else. 
Hopefully VIA will answer...
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
