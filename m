Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUKTQ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUKTQ6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUKTQ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:58:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63241 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263117AbUKTQ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:58:03 -0500
Date: Sat, 20 Nov 2004 16:57:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending Config-Requests"
Message-ID: <20041120165758.F13550@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041019131240.A20243@flint.arm.linux.org.uk> <20041120131159.C13550@flint.arm.linux.org.uk> <1100954046.11951.0.camel@localhost.localdomain> <20041120142104.D13550@flint.arm.linux.org.uk> <419F5E28.7070606@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <419F5E28.7070606@microgate.com>; from paulkf@microgate.com on Sat, Nov 20, 2004 at 09:09:28AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 09:09:28AM -0600, Paul Fulghum wrote:
> Russell King wrote:
> > On Sat, Nov 20, 2004 at 12:34:07PM +0000, Alan Cox wrote:
> > 
> >>On Sad, 2004-11-20 at 13:11, Russell King wrote:
> >>
> >>>So, what can I do with this bug?  Just close or reject it, or what?
> >>>Maybe Alan or Paul would like to assign this bug to themselves?
> >>>
> >>
> >>I thought that was fixed in 10rc and 2.6.9-ac
> > 
> > 
> > Maybe, I have no idea - no one updated the bug, and I'd just like to
> > get rid of it one way or the other.
> 
> This was fixed (post 2.6.9) with the addition of the ldisc->hangup
> method in the ppp_async and ppp_synctty line disciplines.

Right, I've closed the bug then.  It's a shame someone else couldn't
have done that when the bug was known to have been fixed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
