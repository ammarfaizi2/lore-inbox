Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288761AbSADUze>; Fri, 4 Jan 2002 15:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288762AbSADUzZ>; Fri, 4 Jan 2002 15:55:25 -0500
Received: from ns.ithnet.com ([217.64.64.10]:31498 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288761AbSADUzP>;
	Fri, 4 Jan 2002 15:55:15 -0500
Date: Fri, 4 Jan 2002 21:55:03 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: brownfld@irridia.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020104215503.7c43dac2.skraw@ithnet.com>
In-Reply-To: <3C360D6E.9020207@athlon.maya.org>
In-Reply-To: <200201040019.BAA30736@webserver.ithnet.com>
	<3C360D6E.9020207@athlon.maya.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jan 2002 21:15:42 +0100
Andreas Hartmann <andihartmann@freenet.de> wrote:

[I will answer not all of your questions, as this is a matter of business, too]

> > On all boxes I run currently (all 1GB or below RAM), I cannot find    
> > _major_ issues.                                                       
> 
> 
> Question is: which nature is your application / load of the system?

Generally we do not drive the boxes up to the edge. Our philosophy is to throw
money at the problem, before it actually arises. Yes, I can see the future ...
;-)

> [...] Do you have your tables on raw partitions (without caching; as 
> you can do it with UDB)?

No.

> How big are the partitions you are mounting at once? In my case, all the 
> partitions together have about 70GB (all reiserfs).

about 130 GB, all reiserfs.

> I want to know it, because I think the problem depends on how much 
> different HD-memory is accessed.

I guess you should tilt that theory.
Have you already tried to throw a big SPARC at the problem?

> If you have applications, which doesn't 
> access to much memory, you can't view the problems.
> If you access more than 1G (and you do not just copy, but rsync e.g.) 
> and you have only 512MB of RAM, the machine swaps a lot with most actual 
> 2.4.-kernels (patches).

Can you provide a simple and reproducible test case (e.g. some demo source),
where things break? I am very willing to test it here.

Regards,
Stephan


