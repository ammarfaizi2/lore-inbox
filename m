Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293373AbSCFJCJ>; Wed, 6 Mar 2002 04:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293378AbSCFJB7>; Wed, 6 Mar 2002 04:01:59 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:54692 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293373AbSCFJBs>; Wed, 6 Mar 2002 04:01:48 -0500
Date: Wed, 6 Mar 2002 10:47:24 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrew Morton <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Problem with 3c905B nic
In-Reply-To: <200203060842.g268gfq21995@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0203061045130.2839-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Denis Vlasenko wrote:

> Hi,
> 
> I have a NFS client which was connected to the server directly
> by crossover cable. 100mbit Enternet was working as expected
> (~10mbytes/sec peak). Recently I had to move to different
> location and now I'm connected to the same server through
> stack of four HP ProCurve 4000M switches.
> Now I'm getting ~2mbytes/sec peak.

Can you verify your negotiated link status?
 
> Since I boot from network I have NIC drivers compiled in,
> tried to instruct 3c59x.c to be more verbose with
> ether=0,0,0x8200,eth0 with no success... why?

Out of interest, where does 0x8200 come from? 

> I put debug printk in the source, it does not print:
>         if (dev->mem_start) {
>                 /*
>                  * The 'options' param is passed in as the third arg to the
>                  * LILO 'ether=' argument for non-modular use
>                  */
>                 option = dev->mem_start;
> ===>            printk(KERN_DEBUG "VDA: ether=xx,xx,0x%08x,xxx\n",dev->mem_start);
>         }
> 
> Ok, I have recompiled drivers/net/3c59x.c with vortex_debug=4
> set manually and now I see I'm having problems.
> 
> Do someone know what's up here?

Could you elaborate more on which particular problem you're having. This 
looks like a mixed bag.

Regards,
	Zwane


