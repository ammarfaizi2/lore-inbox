Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBHUDE>; Thu, 8 Feb 2001 15:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129354AbRBHUCx>; Thu, 8 Feb 2001 15:02:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2564 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129106AbRBHUCg>;
	Thu, 8 Feb 2001 15:02:36 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102080808.f1888NM15820@flint.arm.linux.org.uk>
Subject: Re: nfs_refresh_inode: inode number mismatch
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Thu, 8 Feb 2001 08:08:23 +0000 (GMT)
Cc: jsun@mvista.com (Jun Sun), linux-kernel@vger.kernel.org
In-Reply-To: <14977.62674.189100.548731@notabene.cse.unsw.edu.au> from "Neil Brown" at Feb 08, 2001 12:22:26 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
> On Wednesday February 7, jsun@mvista.com wrote:
> > This is a weird problem that I am looking at right.  It seems to indicate a
> > bug in the nfs server.
> > 
> > I have a MIPS machine that boots from a NFS root fs hosted on a redhat 6.2
> > workstation.  Everything works fine except that after a few reboots I start to
> > see the error messages like the following:
> 
> What verison of Linux?  If it is less than 2.2.18, then an upgrade 
> will help you a lot.
> 
> If it is >= 2.2.18, I will look some more.

Note that you need to upgrade the server, not the client.  Also, make sure
you don't reboot the client more than once in a 2 minute time window.
--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
