Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbVLAVGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbVLAVGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbVLAVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:06:46 -0500
Received: from natfrord.rzone.de ([81.169.145.161]:6578 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S1751724AbVLAVGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:06:45 -0500
Subject: Re: [PATCH] x86_64: Display HPET timer option
From: Erwin Rol <mailinglists@erwinrol.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201204339.GC997@wotan.suse.de>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
	 <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
	 <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
	 <20051201204339.GC997@wotan.suse.de>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 22:06:37 +0100
Message-Id: <1133471197.3604.3.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 21:43 +0100, Andi Kleen wrote:
> On Thu, Dec 01, 2005 at 12:30:03PM -0800, Zwane Mwaikambo wrote:
> > On Thu, 1 Dec 2005, Linus Torvalds wrote:
> > 
> > > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > > >
> > > > Currently the HPET timer option isn't visible in menuconfig.
> > > 
> > > Do you want it to?
> > > 
> > > Why would you ever compile it out?
> > 
> > For timer testing purposes i sometimes would like not to use the HPET. 
> > Would a runtime switch be preferred?
> 
> nohpet already exists.
> 

And luckily it does cause without "nohpet" i can't boot my shuttle
ST20G5, the NMI watchdog kills it because ti hangs when initializing the
hpet. If the nmi watchdog is off it just hangs for ever. 

- Erwin
 


