Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbUKDOea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbUKDOea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUKDOar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:30:47 -0500
Received: from [195.68.36.78] ([195.68.36.78]:12492 "EHLO citron.linagora.com")
	by vger.kernel.org with ESMTP id S262239AbUKDO3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:29:43 -0500
Message-ID: <1099579352.418a3fd82b569@intranet.linagora.com>
Date: Thu,  4 Nov 2004 15:42:32 +0100
From: tlaurent@linagora.com
To: "gene.heskett@verizon.net" <gene.heskett@verizon.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Doug McNaught <doug@mcnaught.org>, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net> <200411040739.01699.gene.heskett@verizon.net> <87wtx1220n.fsf@asmodeus.mcnaught.org> <200411040911.51923.gene.heskett@verizon.net>
In-Reply-To: <200411040911.51923.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 192.168.1.254
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Gene Heskett <gene.heskett@verizon.net>: 
 
> On Thursday 04 November 2004 08:10, Doug McNaught wrote: 
> >Gene Heskett <gene.heskett@verizon.net> writes: 
> >> [root@coyote linux-2.6.10-rc1-bk13]# grep SYSRQ .config 
> >> CONFIG_MAGIC_SYSRQ=y 
> > 
> >Did you also enable it in /proc? 
> > 
> >-Doug 
>  
> I just now discovered it defaults to a 0, so I put an  
> echo 1 >proc/sys/kermel/sysrq 
> in rc.local just now. 
 
You might also want to have a look at /etc/sysctl.conf. Some distros put a 
kernel.sysrq=0 in it... 
 
Cheers, 
Thibaut 
 
>  
> Thanks for the heads up. 
>  
> --  
> Cheers, Gene 
> "There are four boxes to be used in defense of liberty: 
>  soap, ballot, jury, and ammo. Please use in that order." 
> -Ed Howdershelt (Author) 
> 99.28% setiathome rank, not too shabby for a WV hillbilly 
> Yahoo.com attorneys please note, additions to this message 
> by Gene Heskett are: 
> Copyright 2004 by Maurice Eugene Heskett, all rights reserved. 
 

