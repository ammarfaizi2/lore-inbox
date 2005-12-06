Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVLFVvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVLFVvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVLFVvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:51:17 -0500
Received: from soundwarez.org ([217.160.171.123]:42176 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1030261AbVLFVvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:51:16 -0500
Date: Tue, 6 Dec 2005 22:51:14 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206215114.GA25007@vrfy.org>
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com> <200512040446.32450.luke-jr@utopios.org> <20051204232205.GF8914@kroah.com> <4395A72E.6030006@tmr.com> <20051206175919.GI3084@kroah.com> <4395FE34.5070406@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395FE34.5070406@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 04:10:12PM -0500, Bill Davidsen wrote:
> Greg KH wrote:
> >On Tue, Dec 06, 2005 at 09:58:54AM -0500, Bill Davidsen wrote:
> >
> >>If a new udev config is needed with every new kernel, why isn't it in
> >>the kernel tarball? Is that what you mean by "broken distro
> >>configuration?" The info should be in /proc or /sys and not in an
> >>external config file, particularly if a different versions per-kernel is
> >>needed and people are trying new kernels and perhaps falling back to the
> >>old.
> >
> >Every distro has different needs for its device naming and groups and
> >other intergration into the boot process.  To force all of them to unify
> >on one-grand-way-of-doing-things would just not work out at all.
> 
> Did I say that. No, I said it would be desirable to provide a working 
> config with the kernel, to which something could be symlinked. This no 
> more "forces" distributions to do anything than LSB. It would provide a 
> default, it would provide something working, and if I didn't like it I 
> could change it. But I wouldn't have to try and change thing way up in 
> initrd so I can boot one kernel or another...

That already works today. All distros I know are capable to run
kernel.org kernels, if you care yourself, that the rootfs is accessible.

> >Look at all of the variations in the udev tarball between the different
> >vendor configurations (we put them in there for other people to base
> >their distro off of, if they want to.)
> >
> >So providing this config in the kernel will just not work, sorry.
> 
> We have standard libraries, header files, system calls, why is a 
> standard in this case a bad thing? Actually not even a standard, 
> perhaps, a default. It wouldn't make it one bit harder to have custom 
> names, for those who believe different is better.

Just give it its time. It will happen without anybody claiming to have
or to be a standard. We are already much more similar than we've ever
been across the current devel releases of all major distros.
The complete replacement of hotplug by udev rules, kernel uevents and
kernel event replay triggers made the situation so much simpler and better
than it ever was.

It's, as in most cases, not about someone defining some standard, talk a
lot about it, create an interest group, write a noisy paper... - it's the
whole lot of real work to come up with a solution that is convincing enough
for the involved parties, and to manage all the different interests people
have and still get things done at the same time. It has almost nothing
to do with a "standard".

Convergence will just happen, cause it makes sense and there is a reasonable
way to do it. And there was no such thing in that area in the past that
made this kind of sense.

And yeah, the never ending discussion about stupid options like devfs
does not help anything here. It should have been removed a long time
ago, so that the the confused people start to walk in the right direction
instead of delaying the needed convergence progress again and again.

Thanks,
Kay
