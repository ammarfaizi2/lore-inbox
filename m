Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUCSVHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUCSVHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:07:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63493 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261236AbUCSVHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:07:25 -0500
Date: Fri, 19 Mar 2004 21:07:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: David Hinds <dhinds@sonic.net>, daniel.ritz@gmx.ch,
       linux-kernel@vger.kernel.org
Subject: Re: REMINDER: 2.4.25 and 2.6.x yenta detection issue
Message-ID: <20040319210720.J14431@flint.arm.linux.org.uk>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	David Hinds <dhinds@sonic.net>, daniel.ritz@gmx.ch,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403191509280.2227-100000@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0403191509280.2227-100000@dmt.cyclades>; from marcelo.tosatti@cyclades.com on Fri, Mar 19, 2004 at 03:14:54PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 03:14:54PM -0300, Marcelo Tosatti wrote:
> It seems the problem reported by Silla Rizzoli is still present in 2.6.x
> and 2.4.25 (both include the voltage interrogation patch by rmk).
> 
> Daniel Ritz made some efforts to fix it, but did not seem to get it right. 

And that effort is still going on.  Daniel and Pavel have been trying
to find a good algorithm for detecting and fixing misconfigured TI
interrupt routing, and this effort is still on-going.

What would be useful is if Silla could test some of Daniel's patches
and provide feedback.

The latest 2.6 patch from Daniel is at:

	http://ritz.dnsalias.org/linux/pcmcia-ti-routing-9.patch

and I'll ask that feedback is sent to linux-pcmcia and not as a reply
to this message (I'm just monitoring what's going on at present.)

Essentially, this patch needs to be well tested before it goes into
mainline.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
