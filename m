Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSHOAWy>; Wed, 14 Aug 2002 20:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHOAWy>; Wed, 14 Aug 2002 20:22:54 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:4623 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S316089AbSHOAWx>; Wed, 14 Aug 2002 20:22:53 -0400
Subject: Re: smp_num_cpus undeclared workaround
From: Scott Bronson <bronson@rinspin.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1029367539.20388.7.camel@emma>
References: <1029367539.20388.7.camel@emma>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 14 Aug 2002 17:25:39 -0700
Message-Id: <1029371140.20412.29.camel@emma>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dammit, I'm sorry about this...

Everything here is true, but this message is incomplete.  I wanted to do
some more research before posting this so I told Evolution to "Send
Later."

Apparently, to Evolution, Send Later means Send in About 15 Minutes.

I'll post again after I've played around some more.  Again, my
apologies.





On Wed, 2002-08-14 at 17:15, Scott Bronson wrote:
> Kernel 2.4.19:
> 
> I was being plagued by the smp_num_cpus undeclared problems that seems
> be circulating since the 2.3 days.  I appear to have triggered it by
> turning SMP on, doing a full build, and then turning it off.  No
> combination of make clean/dep/etc fixes it.  Finally, in desperation, I
> tried:
> 
>         cp .config ~/config.bak
>         make mrproper
>         cp ~/config.bak .config
>         make
> 
> And that fixed it.  Surprising.  Has anyone looked into what file
> isn't being properly cleaned?  Given the LKML traffic that this
> problem has generated, this should probably be fixed.
> 
> 
> Thanks,
> 
>     - Scott
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


