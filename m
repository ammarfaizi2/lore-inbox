Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271240AbTGWTfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271241AbTGWTfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:35:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29701 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271240AbTGWTew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:34:52 -0400
Date: Wed, 23 Jul 2003 20:49:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Lawrence <dgl@integrinautics.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: compact flash IDE hot-swap summary please
Message-ID: <20030723204954.A439@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Lawrence <dgl@integrinautics.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F1ECFDD.D561D861@integrinautics.com> <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Jul 23, 2003 at 07:18:23PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 07:18:23PM +0100, Alan Cox wrote:
> On Mer, 2003-07-23 at 19:11, Dave Lawrence wrote:
> > I have a Zaurus handheld that runs Linux that seems 
> > to be able to hot-swap its IDE compact flash device
> > with no problems.  But I've read in a recent
> > thread "hdparm and removable IDE?" that hot-swap
> > isn't "fully" supported and that is won't be
> > until:
> 
> Thats hot swapping an IDE controller (built into the CF and
> PCMCIA stuff)
> 
> Drive level hotswap is supported only in the "I unmounted it all
> properly first" case and providing your system has the required bus
> isolation. Typically its also only allowed in IDE if you have a
> single disk on the channel. With dual device you tend to have nasty
> accidents pulling something out while the other device is "live"

Any ideas if this is going to be fixed for 2.6?  I think this is a show
stopper, certainly for embedded devices - a fair number of people do use
CF cards in their embedded solutions, and some of us hotplug CF cards to
grab images off our digital cameras.

I've had people at KS/OLS approach me about this issue in both 2.4 and
2.6 kernels.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

