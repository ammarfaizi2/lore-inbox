Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290852AbSARWVI>; Fri, 18 Jan 2002 17:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290853AbSARWUv>; Fri, 18 Jan 2002 17:20:51 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:22923 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S290852AbSARWUh>; Fri, 18 Jan 2002 17:20:37 -0500
Date: Fri, 18 Jan 2002 17:20:02 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <87sn93zvdm.fsf@CERT.Uni-Stuttgart.DE>
Message-ID: <Pine.LNX.4.44.0201181632000.18867-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Florian ,

On Fri, 18 Jan 2002, Florian Weimer wrote:
> "Mr. James W. Laferriere" <babydr@baby-dragons.com> writes:
> > 	Hello Alan ,
> > On Mon, 14 Jan 2002, Alan Cox wrote:
> >> > 1. security, if you don't need any modules you can disable modules entirly
> >> > and then it's impossible to add a module without patching the kernel first
> >> > (the module load system calls aren't there)
> >> Urban legend.
> > 	I do not agree .  Got proof ?  Yes that is a valid question .
> http://www.phrack.org/phrack/58/p58-0x07
	Thank you for the pointer .  Fine you do not need to allow modules
	in order for a hacker to insert their code .  It is still another
	thing to allow modules & not put & use signatures on them .  AFAIK
	Linux doesn't have a method to load encrypted & signed modules at
	this time .  Please ,  someone prove me wrong .  I -personally-
	like statically compiled kernels .  The method being pushed forth
	at present doesn't allow that ,  Unless I am completely mistaken
	about what Alan & the rest have been discussing .  Again PLEASE
	someone prove me wrong about this also .

> Globally preloading a shared library in user space is almost as
> effective, BTW, unless your critical binaries are linked statically
> (which is unusual on most systems nowadays).
	I can beleive that 8-} .  Statically or written to readonly media
 	or the drive hard set to readonly ;-) .  I have followed most of
	Alan's suggestions security concerns over the years & a few that
	I thought of along the way .  Which later I found had been being
	done alot longer than I would have thought .  Tia ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+



