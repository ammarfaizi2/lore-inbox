Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRKMQam>; Tue, 13 Nov 2001 11:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKMQac>; Tue, 13 Nov 2001 11:30:32 -0500
Received: from [216.151.155.121] ([216.151.155.121]:30225 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S276097AbRKMQaZ>; Tue, 13 Nov 2001 11:30:25 -0500
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x has finally made it!
In-Reply-To: <Pine.GSO.4.33.0111131002200.14971-100000@gurney>
	<20011113171836.A14967@emma1.emma.line.org>
From: Doug McNaught <doug@wireboard.com>
Date: 13 Nov 2001 11:30:02 -0500
In-Reply-To: Matthias Andree's message of "Tue, 13 Nov 2001 17:18:36 +0100"
Message-ID: <m34rnyk511.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> On Tue, 13 Nov 2001, Alastair Stevens wrote:
> 
> > For those who haven't seen it yet, Moshe Bar at BYTE.com has revisited his
> > Linux 2.4 vs FreeBSD benchmarks, using 2.4.12 in this case:
> > 
> >  http://www.byte.com/documents/s=1794/byt20011107s0001/1112_moshe.html
> 
> Wow. That person is knowledgeable... NOT. Turning off fsync() for mail
> is just as good as piping it to /dev/null. See RFC-1123.

Umm...  He specifically stated that it was a Very Bad Idea for
production systems.  He simply wanted to measure general throughput
rather than disk latency (which is a bottleneck with fsync()
enabled). 

It's a benchmark, lighten up!  ;)

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
