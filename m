Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281370AbRKEV55>; Mon, 5 Nov 2001 16:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281382AbRKEV5r>; Mon, 5 Nov 2001 16:57:47 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:9006 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S281381AbRKEV5e>; Mon, 5 Nov 2001 16:57:34 -0500
Message-Id: <4.3.2.7.2.20011105133211.00bbfed0@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 05 Nov 2001 13:43:11 -0800
To: Jonathan Lundell <jlundell@pobox.com>, dalecki@evision.ag,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
From: Stephen Satchell <satch@concentric.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Cc: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
In-Reply-To: <p05100302b80c9aab7f40@[10.128.7.49]>
In-Reply-To: <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42>
 <200111042213.fA4MDoI229389@saturn.cs.uml.edu>
 <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:58 AM 11/5/01 -0800, Jonathan Lundell wrote:
>Either too coarse or too fine, often enough, when we're talking about a 
>semi-independent module. Consider, though, a more legitimate non-bloating 
>use of a version field. Rather than try to support all versions, use it to 
>determine whether the two ends of the communication channel are 
>compatible, and fail gracefully because of the incompatible version. Tell 
>the user to update the app, or whatever.

I have software out in the field that has been around for more than ten 
years.  Some of it has been maintenance-free (other than the 
every-other-fortnight bug report that requires a fix) because the 
underlying operating system didn't change.  Some of it has been a 
nightmare, requiring changes for each OS release and in some cases with 
each sub-release in order to keep the feature bloat from knocking out the 
functionality of the program.

Unlike many of you, my client base doesn't upgrade on a whim.  They stick 
with what works.  That means all my software has to be able to run up and 
down the version tree, and I have a real problem maintaining parallel 
versions of code.  In Linux, I have people on 2.0.34 still.  I have people 
running some of my software on old versions of Ultrix on hardware that 
hasn't seen sales for over a decade.  I just found out that software I 
wrote 20 years ago is STILL in use, and customers were inquiring if I was 
available to make changes!

And then there is the problem of who pays for my time to make the app 
update.  I don't charge people for updates as a rule -- that rule may have 
to change for my Linux apps if this ill-thought-out idea goes into the 
kernel.  I expend enough effort trying to keep up with the crap coming out 
of Redmond and Cupertino.

Apologies for the vent, but I just swatted another bug caused by an 
undocumented change in Windows 2000 that nailed one of my apps but good.  I 
shudder to think what XP is going to look like when my clients start 
thinking of "upgrading" their hardware and have XP foisted on them...

Satch

