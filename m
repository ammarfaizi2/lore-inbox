Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTIQJwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTIQJwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:52:44 -0400
Received: from elin.scali.no ([62.70.89.10]:27820 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262719AbTIQJwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:52:41 -0400
Subject: Re: Rik's list of CS challenges
From: Terje Eggestad <terje.eggestad@scali.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309101540270.27932-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0309101540270.27932-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1063792350.2853.73.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Sep 2003 11:52:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got one: 

I've been paying attention the MRAM
http://www.research.ibm.com/resources/news/20030610_mram.shtml (and the
other NV rams comming up, most notabily the optical/polymer
http://www.pcw.co.uk/news/1143633 techs). 

What interest me is that with multiple candidates in the pipeline, it's
a high probability that we'll have a non-volatile DRAM replacement
hitting mainstream computer market within 5-10 years.  

You have the obvious PDA/Laptop application, which I'll not dwell on. 

You have the HA server application where you want fast reboot on power
failure etc. 

I'd expect that there will be a demand of never reboot, only seemless
continue. Booting is after all a "hack" to get around 
- OS bugs
- an easy way of detecting new HW and config the OS according to HW.
- An easy way to upgrade the kernel 

hotplug demands are already rendering pt 2 obsolete. 
UPgrading the kernel while running would be a cool feature. One of the
promises of the micro kernel archs in the early 90's

Is it possible to "reboot" the kernel without affecting the running apps
on the machine?

 

What become more interesting is that while you may have NV RAM, it's not
likely that MRAM is viable on the processor chip. The manufacture
process may be too expensive, or outright impossible, (polymers on chips
that hold 80 degrees C in not likely), leaving you with volatile
register and cache but NV Main RAM. 
- should the OS now schedule "paging" between cache and RAM? 
- atomic syncing/updates of regs/cache to RAM? (checkpointing)

A merge of FS and RAM? (didn't the AS/400 have mmap'ed disks?)


And all the applications I haven't even thought of. 

TJ
 

On Wed, 2003-09-10 at 22:05, Rik van Riel wrote:
> On Wed, 10 Sep 2003, Luca Veraldi wrote:
> 
> > I'm not responsible for microarchitecture designer stupidity.
> > If a simple STORE assembler instruction will eat up 4000 clock cycles,
> > as you say here, well,
> 
> If current trends continue, a L2 cache miss will be
> taking 5000 cycles in 15 to 20 years.
> 
> > I think all we Computer Scientists can go home and give it up now.
> 
> While I have seen some evidence of computer scientists
> going home and ignoring the problems presented to them
> by current hardware constraints, I'd really prefer it
> if they took up the challenge and did the research on
> how we should deal with hardware in the future.
> 
> In fact, I've made up a little (incomplete) list of
> things that I suspect are in need of serious CS research,
> because otherwise both OS theory and practice will be
> unable to deal with the hardware of the next decade.
> 
> 	http://surriel.com/research_wanted/
> 
> If you have any suggestions for the list, please let
> me know.
-- 

Terje Eggestad
Senior Software Engineer
dir. +47 22 62 89 61
mob. +47 975 31 57
fax. +47 22 62 89 51
terje.eggestad@scali.com

Scali - www.scali.com
High Performance Clustering

