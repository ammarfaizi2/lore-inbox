Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSHGK1j>; Wed, 7 Aug 2002 06:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSHGK1j>; Wed, 7 Aug 2002 06:27:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7161 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317772AbSHGK1i>; Wed, 7 Aug 2002 06:27:38 -0400
Subject: Re: Linux 2.4.20-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <p73vg6nhtsb.fsf@oldwotan.suse.de>
References: <200208062329.g76NTqP30962@devserv.devel.redhat.com.suse.lists.linux.kernel>
	  <p73vg6nhtsb.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 12:50:43 +0100
Message-Id: <1028721043.18478.265.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 11:01, Andi Kleen wrote:
> Can you explain this further. How else do you propose to get rid of 
> unmaintained-and-absolutely-hopeless-on-64bit drivers in the configuration? 
> I definitely do not want to get bug reports about these not working on x86-64.

I don't want a tree where every driver has seventeen lines of if IBM and
not 64bit || parisc || x86 || !x86_64 || ia64) && (!wednesdayafternoon)

Its *unmaintainable*.

The sparc64 people don't do it, the mips people don't do it, the ia64
people don't do it, wtf should you get to fill config.in with crap

The _ISA stuff makes sense, thats sensible, but the rest - when people
moan we tell em to fix the drivers.

