Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRCJXn7>; Sat, 10 Mar 2001 18:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRCJXnu>; Sat, 10 Mar 2001 18:43:50 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:47318 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130253AbRCJXnm>; Sat, 10 Mar 2001 18:43:42 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE123@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'John William'" <jw2357@hotmail.com>, linux-kernel@vger.kernel.org
Subject: RE: HP Vectra XU 5/90 interrupt problems
Date: Sat, 10 Mar 2001 15:42:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: John William [mailto:jw2357@hotmail.com]
> 
> I'm having a problem with kernel 2.4.2-SMP on my HP Vectra XU 
> 5/90. This is an old dual-pentium (Neptune chipset) machine.
> 
...
> 
> OR
> 
> If PCI interrupts are shared, force them to be level 
> triggered? Can shared 
> PCI interrupts be edge triggered? If not, then wouldn't this 
> be the correct 
> solution? This isn't specific to the Vectra, but could 
> possibly prevent problems on any machine with a broken BIOS?

PCI interrupts are defined as "level sensitive" and must
be shareable.

~Randy

