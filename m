Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUC2PJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUC2PJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:09:36 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:62418 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262956AbUC2PJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:09:29 -0500
Date: Mon, 29 Mar 2004 08:09:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Hartge <hartge@ds9.gnuu.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
Message-ID: <20040329150927.GC2895@smtp.west.cox.net>
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee> <20040326185103.GB20819@smtp.west.cox.net> <E1B7EHF-0004Jm-DY@ds9.argh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1B7EHF-0004Jm-DY@ds9.argh.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 02:55:09PM +0100, Sven Hartge wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> > On Fri, Mar 26, 2004 at 08:33:18PM +0200, Meelis Roos wrote:
> 
> >> Recent 2.6.5-pre* and -rc1 and -BK don't boot on my Motorola Powerstack
> >> (PReP with no RTAS but with OF).
> >> 
> >> I use netboot to test new kernels.  Normally, the screen is changed to
> >> VGA text mode and the bootloader speaks some lines of info and asks for
> >> the kernel command line. Now, the image is loaded via tftp (as shown by
> >> tcpdump, the last datagram is smaller) and nothing more happens. The
> >> cursor stays where it is - at the beginning of the Booting ... line in
> >> graphics mode OF environment and that's all.
> 
> > Hmm.  Can you hook up a serial line, enable serial console as well and
> > see if anything pops out there?
> 
> I am seeing the same problem here too (Powerstack II with OF).
> 
> Using the serial console does not change to behavior in any way, it is
> just stuck after the transmission of the kernel and no further
> information is printed.

OK.  I _think_ I know where the problem is, and I'll try and look into
it today.

-- 
Tom Rini
http://gate.crashing.org/~trini/
