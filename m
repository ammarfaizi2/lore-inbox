Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVAEBSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVAEBSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVAEBOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:14:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23991 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262214AbVAEBLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:11:39 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, davidsen@tmr.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050104201750.GB22075@alpha.home.local>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com>
	 <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de>
	 <20050103011935.GQ29332@holomorphy.com>
	 <20050103053304.GA7048@alpha.home.local>
	 <20050103142412.490239b8.diegocg@teleline.es>
	 <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com>
	 <20050104201750.GB22075@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104879221.17176.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 00:02:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 20:17, Willy Tarreau wrote:
> So how do some distro makers manage to stabilize their 'enterprise' versions,
> stay on a 2.4.21 with hundreds of patches which overall seem to work pretty
> well ? The distro maker I think about has quite a big crunch of the kernel
> developpers, and I suspect that they do this work themselves. If they can
> refrain from putting new features everyday in their employer's product, why
> can't they do the same for the free version ?

We employ a small army of highly qualified QA and engineering people to
do that. It's very very hard work. In addition we make choices that suit
our business customers but would be very bad for progress if they were
the "base". To a lot of our customers progress is evil unless they can
schedule it six months in advance. 

If the base kernel worked that way we'd not have gotten a useful OS yet.
Don't confuse the deployment goals of big business and the developer
goals of the community. If you stand in the middle you get stretched
into strange directions and eventually (as we found with the Fedora v
RHEL split) you can't do both at the same time.

> one works for me" and stick to it for a time. Indeed, I think that if 2.6.11
> would stay a year in -rc version, then Alan would release tens of 2.6.10
> derivatives which would then become far more stable than what the next 2.6.11
> would be.

It always depends "at what". 2.6.10 is more stable than 2.6.9-ac at SCSI
and USB for example because the backports were too complex.

Alan

