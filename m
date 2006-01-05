Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWAEQbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWAEQbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWAEQbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:31:15 -0500
Received: from styx.suse.cz ([82.119.242.94]:17305 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751474AbWAEQbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:31:14 -0500
Date: Thu, 5 Jan 2006 17:30:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060105163058.GA9381@corona.suse.cz>
References: <200601041200.03593.kernel@kolivas.org> <p73y81vxyci.fsf@verdi.suse.de> <20060105064227.GA6120@corona.suse.cz> <200601051619.17366.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601051619.17366.ak@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 04:19:16PM +0100, Andi Kleen wrote:
> On Thursday 05 January 2006 07:42, Vojtech Pavlik wrote:
> 
> > > I haven't checked recently if keyboard has been fixed by now.
> > 
> > It's not. At this moment it's impossible to remove without significant
> > surgery to the driver, because it'd prevent hotplugging and many KVMs
> > from working.
> 
> Sorry? You say you can't do hot plugging in the keyboard driver
> without a polling timer? 
> 
> That sounds quite bogus to me. A zillion other OS do keyboards
> fine without polling timers.
 
I can either have the polling timer, or the IRQs acquired all the time.
The later needs significant changes to the driver - I currently enable
the IRQs only if a device is present.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
