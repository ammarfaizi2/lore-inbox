Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129336AbRBIAFD>; Thu, 8 Feb 2001 19:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbRBIAEx>; Thu, 8 Feb 2001 19:04:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56819 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129336AbRBIAEm>; Thu, 8 Feb 2001 19:04:42 -0500
Message-ID: <3A8333AC.8485717E@mvista.com>
Date: Thu, 08 Feb 2001 16:02:52 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
In-Reply-To: <200102080808.f1888NM15820@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Neil Brown writes:
> > On Wednesday February 7, jsun@mvista.com wrote:
> > > This is a weird problem that I am looking at right.  It seems to indicate a
> > > bug in the nfs server.
> > >
> > > I have a MIPS machine that boots from a NFS root fs hosted on a redhat 6.2
> > > workstation.  Everything works fine except that after a few reboots I start to
> > > see the error messages like the following:
> >
> > What verison of Linux?  If it is less than 2.2.18, then an upgrade
> > will help you a lot.
> >
> > If it is >= 2.2.18, I will look some more.
> 
> Note that you need to upgrade the server, not the client.  Also, make sure
> you don't reboot the client more than once in a 2 minute time window.

My server was 2.2.14.  I upgraded it to 2.2.18.  It appears that the problem
is gone, although it will probably take a while to be sure.

I do find the "no more than once in 2 minutes" requirement amusing ... :-)

Jun
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
