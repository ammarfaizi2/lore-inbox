Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVLHO6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVLHO6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVLHO6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:58:42 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:21241 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S932183AbVLHO6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:58:41 -0500
Subject: Re: [PATCH] x86_64: Display HPET timer option
From: Erwin Rol <mailinglists@erwinrol.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201211848.GE997@wotan.suse.de>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
	 <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
	 <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
	 <20051201204339.GC997@wotan.suse.de>
	 <1133471197.3604.3.camel@xpc.home.erwinrol.com>
	 <20051201211848.GE997@wotan.suse.de>
Content-Type: multipart/mixed; boundary="=-uori4w5qVrEXiX9N8deC"
Date: Thu, 08 Dec 2005 15:58:32 +0100
Message-Id: <1134053912.3459.1.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 (2.5.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uori4w5qVrEXiX9N8deC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oops the acpidump attachment was missing, here it is.

- Erwin


On Thu, 2005-12-01 at 22:18 +0100, Andi Kleen wrote:
> On Thu, Dec 01, 2005 at 10:06:37PM +0100, Erwin Rol wrote:
> > On Thu, 2005-12-01 at 21:43 +0100, Andi Kleen wrote:
> > > On Thu, Dec 01, 2005 at 12:30:03PM -0800, Zwane Mwaikambo wrote:
> > > > On Thu, 1 Dec 2005, Linus Torvalds wrote:
> > > > 
> > > > > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > > > > >
> > > > > > Currently the HPET timer option isn't visible in menuconfig.
> > > > > 
> > > > > Do you want it to?
> > > > > 
> > > > > Why would you ever compile it out?
> > > > 
> > > > For timer testing purposes i sometimes would like not to use the HPET. 
> > > > Would a runtime switch be preferred?
> > > 
> > > nohpet already exists.
> > > 
> > 
> > And luckily it does cause without "nohpet" i can't boot my shuttle
> > ST20G5, the NMI watchdog kills it because ti hangs when initializing the
> > hpet. If the nmi watchdog is off it just hangs for ever. 
> 
> Can you give details on the machine? lspci, dmidecode, acpidmp output,
> boot log from the hang case?
> 
> Then perhaps it can be blacklisted or the failure otherwise avoided.
> 
> [Looks like I finally need to add DMI decode support to x86-64 too :-/]
> 
> -Andi
> 
> 

--=-uori4w5qVrEXiX9N8deC
Content-Disposition: attachment; filename=acpidump.bin.gz
Content-Type: application/x-gzip; name=acpidump.bin.gz
Content-Transfer-Encoding: base64

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
yeUyr9H9HpV/0LVIsts0qH8Ak72I7rhEAAA=


--=-uori4w5qVrEXiX9N8deC--

