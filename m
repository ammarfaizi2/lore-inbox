Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWBMXEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWBMXEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWBMXEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:04:54 -0500
Received: from smtp.enter.net ([216.193.128.24]:31504 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030255AbWBMXEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:04:53 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 18:13:52 -0500
User-Agent: KMail/1.8.1
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <200602092221.56942.dhazelton@enter.net> <43F08C5F.nailKUSDKZUAZ@burner>
In-Reply-To: <43F08C5F.nailKUSDKZUAZ@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131813.52843.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 08:40, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > > Name a single program (not using libscg) that implements user space
> > > SCSI and runs on as many platforms as cdrecord/libscg does.
> >
> > I'm not the maintainer of a program, and hence I don't have to.
> >
> > But why in the hell do you even _need_ SCSI in userspace when the kernel
> > provides complete facilities? And even then your argument is specious,
> > since
>
> Then please try to inform yourself in order to understand that you are
> wrong.

Inform myself? Before this discussion even began I had spent hours trying to 
figure out how to use libscg and decided to just use the provided linux 
systems and worry about porting to other systems if I ever finished the 
project. As far as I'm concerned, Linux provides enough of an abstraction 
layer that anyone with a bit of programming skill and access to the proper 
documentation can do _anything_ they want.

A personal attack like this is how flame wars get started - I will not be 
party to one. And again you show your colors as a troll, by making a personal 
attack. The only saving grace is that you did explain yourself.

>
> libscg abstracts from a kernel specific transport and allows to write OS
> independent applications that rely in generic SCSI transport.

I still think that on modern operating systems libscg needs to be nothing more 
than a wrapper around the OS specific code. Anything added extra beyond that 
is actually unneeded.

> For this reason, it is bejond the scope of the Linux kernel team to decide
> on this abstraction layer. The Linux kernel team just need to take the
> current libscg interface as given as _this_  _is_ the way to do best
> abstraction.

Why is it the best? Because you wrote it? Beyond cdrtools I have seen only one 
user of it (and I don't know that that program hasn't been silently folded 
into cdrtools recently). The fact that no one else has written a SCSI wrapper 
means a few things. One: That nobody else has ever seen the need for it. Two: 
That most programmers are like me - lazy and unwilling to "reinvent the 
wheel" for any project. In truth, it's not an "either-or" it's both of those 
reasons. 

And my point still remains - applications and libraries must _WORK_ _WITHIN_ 
the framework provided by the OS. No application or library that attempts to 
define the way an OS works is valid - this is a simple fact that you seem 
unable to grasp.

> The Linux kernel team has the freedom to boycott portable user space SCSI
> applications or to support them.

so I'm guessing you think that your userbase is happy with your scheme? If 
they are anything like most people I know they have just resigned themselves 
to using a bad interface or they use a GUI that hides the complexities of the 
interface from them.

And even then, as someone else pointed out, two drives that are identical in 
all respects except color, plugged onto two seperate busses, will appear the 
same in the scanbus listing. How can a user tell them apart?

DRH
