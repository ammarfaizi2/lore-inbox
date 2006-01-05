Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWAEQjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWAEQjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWAEQjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:39:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:57738 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751511AbWAEQjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:39:18 -0500
From: Andi Kleen <ak@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 17:39:05 +0100
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <200601051619.17366.ak@suse.de> <20060105163058.GA9381@corona.suse.cz>
In-Reply-To: <20060105163058.GA9381@corona.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051739.05441.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 17:30, Vojtech Pavlik wrote:
> On Thu, Jan 05, 2006 at 04:19:16PM +0100, Andi Kleen wrote:
> > On Thursday 05 January 2006 07:42, Vojtech Pavlik wrote:
> > 
> > > > I haven't checked recently if keyboard has been fixed by now.
> > > 
> > > It's not. At this moment it's impossible to remove without significant
> > > surgery to the driver, because it'd prevent hotplugging and many KVMs
> > > from working.
> > 
> > Sorry? You say you can't do hot plugging in the keyboard driver
> > without a polling timer? 
> > 
> > That sounds quite bogus to me. A zillion other OS do keyboards
> > fine without polling timers.
>  
> I can either have the polling timer, or the IRQs acquired all the time.
> The later needs significant changes to the driver - I currently enable
> the IRQs only if a device is present.

You mean you run the timer to avoid aquiring the interrupt early? 

-Andi
