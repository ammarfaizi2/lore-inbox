Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbUJZPEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUJZPEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbUJZPEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:04:16 -0400
Received: from holomorphy.com ([207.189.100.168]:52964 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262285AbUJZPEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:04:09 -0400
Date: Tue, 26 Oct 2004 08:03:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Massimo Cetra <mcetra@navynet.it>
Cc: "'Ed Tomlinson'" <edt@aei.ca>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041026150313.GI17038@holomorphy.com>
References: <200410260644.47307.edt@aei.ca> <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 01:40, Chuck Ebbert wrote:
>> To my mind this just points out the need for a bug fix branch.
>> e.g. a branch containing just bug/security fixes against the current 
>> stable kernel.  It might also be worth keeping the branch active for
>> the n-1 stable kernel too.

On Tue, Oct 26, 2004 at 01:09:59PM +0200, Massimo Cetra wrote:
> To my mind, we only need to make clear that a stable kernel is a stable
> kernel.
> Not a kernel for experiments.
> To my mind, stock 2.6 kernels are nice for nerds trying patches and
> willing to recompile their kernel once a day. They are not suitable for
> servers. Several times on testing machines, switching from a 2.6 to the
> next one has caused bugs on PCI, acpi, networking and so on.

This is bunk. I'm running 2.6 on a number of machines I rely upon
heavily as servers etc. on the open net as well as the usual dedicated
kernel hacking machines. The uptimes of the relied-upon systems are
measured in months, at times approaching a year. When it's time for a
reboot, I upgrade to the latest available 2.6.x-mm every time. This is
not just stable, it's running to hardware/power failure territory.

You seem to be under the mistaken assumption that change is frivolous
and the result of masturbatory abuse of the kernel as a toy. This is
very clearly not the case. Linux kernel programmers write their patches
because there is a need for the change, and Linux kernel maintainers
merge patches because they understand the need for the change is great
enough.

This process very successfully converges. More bugs are fixed than are
introduced every release by a large margin. If you don't understand why
regressions are inevitable, you don't understand that humans are
imperfect. And not even your beloved 2.4 is immune to regressions.


On Tue, Oct 26, 2004 at 01:09:59PM +0200, Massimo Cetra wrote:
> The direction is lost. How many patchsets for vanilla kernel exist? 
> Someone has decided that linux must go on desktops as well and
> developing new magnificent features for desktop users is causing serious
> problems to the ones who use linux at work on production servers.
> 2.4 tree is still the best solution for production.
> 2.6 tree is great for gentoo users who like gcc consuming all CPU
> (maxumum respect to gentoo but I prefer debian)

What does the number of patchsets have to do with anything? What's the
obsession with featurework? Why do you assume it's frivolous?

Deficiencies can arise in forms beyond bugs. Addressing those is one of
the things the new development model was designed to cover. They are
nowhere near as problematic as you suggest. For instance, anon_vma was
merged almost entirely without incident, thanks to the efforts of Hugh
Dickins.

The fact is, you're not complaining about those features anyway. PCI,
etc. normal driver and networking layer turnover, and networking is
largely a different universe from the rest of the kernel. These areas
are actually relatively conservatively maintained in comparison to what
you're pointing at, so complaining about the new development model
causing regressions in them is absurd (as in reductio ad asburdum).


-- wli
