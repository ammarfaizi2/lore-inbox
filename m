Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266013AbRGGEMJ>; Sat, 7 Jul 2001 00:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266015AbRGGEMA>; Sat, 7 Jul 2001 00:12:00 -0400
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:41442 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S266013AbRGGEL6>; Sat, 7 Jul 2001 00:11:58 -0400
Message-ID: <3B469917.8A334B6@home.com>
Date: Sat, 07 Jul 2001 01:07:35 -0400
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: fdavis112@juno.com, gregrollins@telocity.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver doesn't work as module on 2.4.6
In-Reply-To: <3B4677EB.966BA972@home.com> <3B467FF6.A2D991E7@telocity.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Davis wrote:
> 
> John,
>    What do the logs say?
> Regards,
> -Frank
> --

Jul  5 23:32:48 speedy kudzu:  failed 
Jul  5 23:32:48 speedy kudzu: Hardware configuration timed out. 
Jul  5 23:32:48 speedy kudzu: Run '/usr/sbin/kudzu' from the command
line to re-
detect. 
Jul  5 23:32:48 speedy sysctl: net.ipv4.ip_forward = 0 
Jul  5 23:32:53 speedy lpd: lpd startup succeeded
Jul  5 23:32:48 speedy sysctl: net.ipv4.conf.all.rp_filter = 1 
Jul  5 23:32:48 speedy sysctl: error: 'net.ipv4.ip_always_defrag' is an
unknown 
key 
Jul  5 23:32:48 speedy sysctl: error: 'kernel.sysrq' is an unknown key 
Jul  5 23:32:48 speedy network: Setting network parameters succeeded 
Jul  5 23:32:49 speedy network: Bringing up interface lo succeeded 
Jul  5 23:32:49 speedy network: Bringing up interface eth0 succeeded 
Jul  5 23:32:50 speedy portmap: portmap startup succeeded 

Greg Rollins wrote:
> 
> John Kacur wrote:
> 
> > Hi
> >
> > With Kernel 2.4.6, when I compile the Tulip driver as a module, I don't
> > have network connectivity. I can ping myself, and netstat -rn gives the
> > same table as with earlier kernels, but I can't connect to any of the
> > other computers on my network. (network = 1 pentium 120, and 1 pentium
> > 133 running a 2.2.16 and a 2.0.36 kernel respectively.) (the module is
> > loaded correctly and I have all the correct levels of support programs
> > as listed in the Changes file.) When I compile the Tulip driver directly
> > into the Kernel, it works.
> >
> > I would be happy to provide more information to anybody who wants to try
> > to figure this one out, just ask me what you need to know.
> >
> > Thanks
> >
> > John Kacur
> >
> > jkacur@home.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> I haven't had this problem.  I did my compile last p.m. and so far my Compaq
> Deskpro is running better than ever.  Which tulip based card are you
> running?  Mine is a Linksys 10/100.  More detail please.  I'm doing a modular
> load also.
> 
> Greg Rollins
> gregrollins@telocity.com
> 
Mine is also a Linksys 10/100
