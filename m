Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUCOT3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbUCOT2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:28:24 -0500
Received: from mail1.kontent.de ([81.88.34.36]:49813 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262730AbUCOT1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:27:35 -0500
Date: Mon, 15 Mar 2004 20:27:36 +0100
From: Sascha Wilde <wilde@sha-bang.de>
To: michf@post.tau.ac.il
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.2 reboot hangs on AMD Athlon System
Message-ID: <20040315192736.GA628@kenny.sha-bang.local>
References: <A6974D8E5F98D511BB910002A50A6647615F4EB9@hdsmsx402.hd.intel.com> <1079244503.2173.142.camel@dhcppc4> <20040314183558.GA563@kenny.sha-bang.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314183558.GA563@kenny.sha-bang.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin wrote:
> On Sun, Mar 14, 2004 at 07:35:58PM +0100, Sascha Wilde wrote:
> > On Sun, Mar 14, 2004 at 01:08:25AM -0500, Len Brown wrote:
> > > Curious that this happens
> > > 1. only on 2.6
> > 
> > yes, but true: any other reboot code I've come across (including
> > those of the other Linux kernel versions) work as expected on the
> > box.
> > 
> > > 2. with acpi=off and "acpi=on"
> 
> also try with noapic boot option. It was supposedly fixed (cause a
> problem with my system) but may still causing problems for you.

Just tried that, no effect...  :-(

Something must be strangely different between the way 2.6.x tries to
reboot the System and any other Kernel-version does.  Who is the
Maintainer of this code?  Or maybe even better, who did the changes,
made to the reboot-code in 2.6?  (There is a ne file reboot.c, but
without any author notice)

Please cc me in any reply, I'm not subscribed to the lkml.

cheers
-- 
Sascha Wilde  :  "I heard that if you play the Windows CD backward, you
              :  get a satanic message. But that's nothing compared to
              :  when you play it forward: It installs Windows...." 
              :  -- G. R. Gaudreau
