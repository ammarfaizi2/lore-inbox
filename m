Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbRAVQnS>; Mon, 22 Jan 2001 11:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRAVQnH>; Mon, 22 Jan 2001 11:43:07 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:28331 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132559AbRAVQnB> convert rfc822-to-8bit; Mon, 22 Jan 2001 11:43:01 -0500
Date: Mon, 22 Jan 2001 17:26:42 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jorge Nerin <comandante@zaralinux.com>
cc: Dominik Kubla <dominik.kubla@uni-mainz.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC errors
In-Reply-To: <3A674160.A6621B8C@zaralinux.com>
Message-ID: <Pine.GSO.3.96.1010119212502.19533D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Jorge Nerin wrote:

> >  It's the first report of APIC errors on a P5 system I have seen, so it's
> > probably not a result of a bad motherboard design.  I'd recommend to check
> > if the system doesn't get overheated.  You may also be unlucky to have a
> > faulty board.
> 
> Hey, it's not the first, some time ago when it began to be reported a
> lot of people with various systems asked at the same time about the same
> thing :)

 I've seen a lot of reports but they were from P6 systems' owners.

> LOC:    1620963    1620962 
> ERR:       2697
> [coma@quartz coma]$ uptime 
>   8:14pm  up  4:30,  0 users,  load average: 0.19, 0.11, 0.09

 This rate of errors is alarming.  You get an error every six seconds on
the average. 

> but my system works ok, mostly, now I have just upgraded a Realtek 8029
> (10Mb) because it gets hung to a Realtek 8139 (100Mb) just to found the
> mobo has some kind of busmastering problems, but that's another story.

 The hangs might actually be a result of interrupt delivery problems (just
as other people report).

> P.D. And as you suggested it runs very hot, about 50ºC at the cpus when
> both are at full use.

 Well, 50 degrees is not that hot -- CPUs are actually speced for up to 70
degrees ambient temperature (that means the maximum temperature of the
case, not the heatsink!), but you need to ensure proper cooling. 

 After one and a half year since the error reporting is enabled I have yet
to see a hardware error to be reported by an APIC in my system.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
