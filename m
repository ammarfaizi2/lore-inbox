Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSEFMfp>; Mon, 6 May 2002 08:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314404AbSEFMfo>; Mon, 6 May 2002 08:35:44 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:49550 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314403AbSEFMfn>; Mon, 6 May 2002 08:35:43 -0400
Date: Mon, 6 May 2002 14:14:25 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Tim Waugh <twaugh@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add NetMos 9835 to parport_serial
In-Reply-To: <20020506095735.Y27042@redhat.com>
Message-ID: <Pine.LNX.4.44.0205061359570.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Tim Waugh wrote:

> On Mon, May 06, 2002 at 08:17:52AM +0200, Zwane Mwaikambo wrote:
> 
> > +	/* netmos_9835 */		{ 1, { { 2, 3}, } },
> 
> Are you sure these values are correct?  They are different to the ones
> in ftp://people.redhat.com/twaugh/patches/linux25/linux-netmos.patch.
> 
> That patch seems to work for some people but not for others, and I
> have no idea why; until that's sorted out I'm quite reluctant to
> submit any NetMos support to the mainstream kernel.  The failure mode
> is a complete lock-up. :-(

All the patches i've seen thus far were for some other chip (forgot the 
ID), but for that 9835 i needed it desperately so i tested it quite a lot. 

+	/* netmos_9835 (not tested) */	{ 1, { { 2, -1 }, } },

I'm not sure about the others, but i doubt that one would work. Where 
there conflicting success/failure reports for the same devices?

> Perhaps you could chase the oddity you found and see if you can figure
> out what's going on?

I'll definately do that this evening.

Regards,
	Zwane

-- 
http://function.linuxpower.ca
		

