Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUCZSxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbUCZSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:52:21 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:27550 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S261518AbUCZSvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:51:10 -0500
Date: Fri, 26 Mar 2004 11:51:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
Message-ID: <20040326185103.GB20819@smtp.west.cox.net>
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 08:33:18PM +0200, Meelis Roos wrote:

> Recent 2.6.5-pre* and -rc1 and -BK don't boot on my Motorola Powerstack
> (PReP with no RTAS but with OF).
> 
> I use netboot to test new kernels.  Normally, the screen is changed to
> VGA text mode and the bootloader speaks some lines of info and asks for
> the kernel command line. Now, the image is loaded via tftp (as shown by
> tcpdump, the last datagram is smaller) and nothing more happens. The
> cursor stays where it is - at the beginning of the Booting ... line in
> graphics mode OF environment and that's all.

Hmm.  Can you hook up a serial line, enable serial console as well and
see if anything pops out there?

-- 
Tom Rini
http://gate.crashing.org/~trini/
