Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbRE1PTs>; Mon, 28 May 2001 11:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbRE1PTi>; Mon, 28 May 2001 11:19:38 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:47069 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S261741AbRE1PTb>; Mon, 28 May 2001 11:19:31 -0400
Message-ID: <DD0DC14935B1D211981A00105A1B28DB033ED2F0@NL-ASD-EXCH-1>
From: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
Date: Mon, 28 May 2001 10:19:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > Performance is back to that of 2.4.2-ac26, and stability is a lot >
better. Under 
> > heavy FS pressure 2.4.5-ac2 is about 5-10% faster than vanilla 2.4.5, >
the aa1,2 
> > kernels have the same performance of vanilla 2.4.5. 
> > 
> > Which one of your changes affected performance so much? 

> Its much more a case that the 2.4.5 tree got fixed and I picked up the >
2.4.5 
> changes. Its still not perfect (bigmem will deadlock again as in 2.4.5 >
vanilla 
> now) but its a much better basis to work from again 

But the claim was that 2.4.5-ac2 is faster than 2.4.5 plain, so which
changes are in 2.4.5-ac2 that would make it faster than 2.4.5 plain? Also, I
don't know if 2.4.5-ac1 is as fast as 2.4.5-ac2 for Fabio. If not, then it's
a change in the 2.4.5-ac2 changelog. If it is as fast, it is one of the
changes in the 2.4.5-ac1 changelog.

I haven't tried plain kernels for a long time, but 2.4.5-ac1 is definately a
lot slower for interactive use than 2.4.4-ac8 so I've gone back to using
that version. I haven't tried 2.4.5-ac2 to see if that improves upon -ac1.

The VM in 2.4.5 might be largely 'fixed' and I know that the VM changes in
-ac were considered to be but still broken, however for me they worked
better than what is in 2.4.5.

I have a rather aging P5MMX at 200MHz with 64MB RAM, and I'm only judging
interactive use (not measuring anything like compile times etc).


with greetings,

--Tim
