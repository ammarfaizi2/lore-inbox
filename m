Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291889AbSBYAIJ>; Sun, 24 Feb 2002 19:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291890AbSBYAH7>; Sun, 24 Feb 2002 19:07:59 -0500
Received: from Expansa.sns.it ([192.167.206.189]:58640 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291889AbSBYAHr>;
	Sun, 24 Feb 2002 19:07:47 -0500
Date: Mon, 25 Feb 2002 01:07:42 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Paul G. Allen" <pgallen@randomlogic.com>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C775FEF.BDA0253C@randomlogic.com>
Message-ID: <Pine.LNX.4.44.0202250100540.15348-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At this link:

 http://www.cs.utk.edu/~rwhaley/ATLAS/gcc30.html

you can find an interesting explanation why code compiled with gcc 3.0 is
mostly slower than code compiled with gcc 2.95 on x86 CPUs (but it is
really faster on other platforms like alpha and sparc64).

basically the main reasons semm to be the scheduler algorithm and the fpu
stack handling, but I suggest to read the full study.


I would be interested to know if this apply to gcc 3.1 too.

Luigi

On Sat, 23 Feb 2002, Paul G. Allen wrote:

> Andrew Morton wrote:
> >
> > hugang wrote:
> > >
> > > On Fri, 22 Feb 2002 23:40:09 -0500
> > > Justin Piszcz <war@starband.net> wrote:
> > >
> > > ...
> > > > GCC 2.95.3
> > > ...
> > > > System is 899 kB
> > > ...
> > > > GCC 3.0.4
> > > ...
> > > > System is 962 kB
> > > ...
> > > >
> > > Why the system size is different. Possble your use differ config.
> >
>
> The important thing is:
>
> Which compiler, of all of the different versions, generates the most
> stable and fastest code. Compile speed and kernel size is not NEARLY as
> important as performance. So, which compiler fits the bill?
>
> PGA
> --
> Paul G. Allen
> Owner, Sr. Engineer, Security Specialist
> Random Logic/Dream Park
> www.randomlogic.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

