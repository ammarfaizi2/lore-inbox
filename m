Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289844AbSBKRBl>; Mon, 11 Feb 2002 12:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289849AbSBKRBb>; Mon, 11 Feb 2002 12:01:31 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:16596 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289844AbSBKRBS>; Mon, 11 Feb 2002 12:01:18 -0500
Date: Mon, 11 Feb 2002 18:53:05 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Kristian <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU0
In-Reply-To: <20020211172749.2bdadec7.kristian.peters@korseby.net>
Message-ID: <Pine.LNX.4.44.0202111849540.17361-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Kristian wrote:

> Hello.
> 
> Since I converted one box to Debian 3.0 I'm getting strange errors related to APM.
> When I push the power button (or do "apm -s") the box suspends normally. But it comes back almost immediately with this error:
> 
> APIC error on CPU0: 00(40)
> 
> I grepped the kernel source and found that "40" means reserved APIC error. What does that mean exactly ? BTW: I enabled "local APIC on uniprocessors" but this behaviour also appears without enabling that option.
> 
> Strangely this error won't appear with Redhat 7.2 and earlier versions. (I've never had any problems.)

Mikael Pettersson submitted a patch which fixed that for me, its 
definately in 2.4 mainline. Which kernel is in Debian 3.0?

Regards,
	Zwane Mwaikambo


