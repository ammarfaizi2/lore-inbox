Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272635AbRHaIi1>; Fri, 31 Aug 2001 04:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272637AbRHaIiS>; Fri, 31 Aug 2001 04:38:18 -0400
Received: from access-35.98.rev.fr.colt.net ([213.41.98.35]:49672 "HELO
	phoenix.linuxatbusiness.com") by vger.kernel.org with SMTP
	id <S272635AbRHaIiD>; Fri, 31 Aug 2001 04:38:03 -0400
Subject: Re: smp freeze on 2.4.9
From: Philippe Amelant <philippe.amelant@free.fr>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <E15cRWe-00013T-00@the-village.bc.nu>
In-Reply-To: <E15cRWe-00013T-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 31 Aug 2001 10:38:15 +0200
Message-Id: <999247095.12408.25.camel@avior>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On jeu, 2001-08-30 at 15:06, Alan Cox wrote:
> > interresting, i notice that i have some error apic in kernel message
> > with 2.4.3
> > i will search that on lkml archive
> 
> Lots of apic errors imply problems on the link between the processors and
> io controller. A few is basically ok (there is a checksum) but a huge number
> and one day it'll checksum a bad frame ok and you are history
> 

So I think it's ok for my 2.4.3, I just have about 5 ~ 10 apic error by
hour

> There is also a problem with Linus tree where apic errors causing event
> replays where the erroring component was not the CPUs can cause crashes.
> That is fixed in -ac.

I have tried 2.4.9-ac4 and i still have a freeze in few minutes, but
when i configured it with noapic all seem ok, I use the box 3 hours
without freeze

Thank
> 
> Alan
> 


