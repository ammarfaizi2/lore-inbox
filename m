Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVA1NnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVA1NnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVA1NnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:43:09 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:30610 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261247AbVA1NnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:43:06 -0500
Subject: Re: DVD burning still have problems
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1106610498.10239.108.camel@localhost.localdomain>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com> <20050124150755.GH2707@suse.de>
	 <1106594023.6154.89.camel@localhost.localdomain>
	 <20050124204529.GA19242@suse.de>
	 <1106598811.6154.93.camel@localhost.localdomain>
	 <1106607691.13336.10.camel@localhost>
	 <1106610498.10239.108.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 14:42:55 +0100
Message-Id: <1106919775.13188.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 23:48 +0000, Alan Cox wrote:
> On Llu, 2005-01-24 at 23:01, Kasper Sandberg wrote:
> > > there are certainly chipset and CPU errata in this area.
> > would this mean that i should not use cpu frequency scaling?
> 
> Worth an experiment but I'd be suprised if it was your fix. The more
> data the better however 
I disabled cpufreq in the kernel, acpi i still have in kernel.. when i
booted i did acpi=off, and changed IO scheduler to anticipatory
i just burned a DVD, and it works ;D pretty neat, im not sure what
caused it. but im glad.. i still have the small change in scsi_ioctl.h,
however nothing appears in dmesg.. gonna burn one more dvd in a little
bit, if it doesent work, i will let you know, if you dont hear more
about it, assume it works :DD

btw: the reason i changed to anticipatory from cfq is that i noticed
that sometimes the speed dropped abit, and thought it might have
something to do with it, and, with as it did not
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

