Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUAKWig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUAKWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:38:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40207 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266021AbUAKWie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:38:34 -0500
Date: Sun, 11 Jan 2004 22:38:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] mark ide-cs broken
Message-ID: <20040111223830.C10920@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20040111111607.A1931@flint.arm.linux.org.uk> <20040111214716.GW18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040111214716.GW18208@waste.org>; from mpm@selenic.com on Sun, Jan 11, 2004 at 03:47:16PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 03:47:16PM -0600, Matt Mackall wrote:
> On Sun, Jan 11, 2004 at 11:16:07AM +0000, Russell King wrote:
> > Hi,
> > 
> > After receiving this bug report: http://bugme.osdl.org/show_bug.cgi?id=1457
> > and talking to Arjan, it would appear that IDECS is known to be broken.
> > Arjan has confirmed that he sees the same behaviour with his PCMCIA CDROM
> > using both 2.6 and 2.4.2x kernels.
> > 
> > Therefore, I suggest that we mark it broken.  The patch below is for 2.6.1
> > kernels.
> 
> It's still working for me as of 2.6.0 with stock kernel and CF, so
> this is probably premature.

Ok.  However, we need some way of quiescing/directing bug reports for
ide-cs with real disks to the right department (that being the IDE
department, not the PCMCIA department.)

Any better suggestions?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
