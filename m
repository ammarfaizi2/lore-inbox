Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316268AbSEWHqJ>; Thu, 23 May 2002 03:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316313AbSEWHqI>; Thu, 23 May 2002 03:46:08 -0400
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:27258 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316268AbSEWHqI>; Thu, 23 May 2002 03:46:08 -0400
Date: Thu, 23 May 2002 08:45:21 +0100
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] lvm sanitation in 2.5
Message-ID: <20020523074521.GC866@fib011235813.fsnet.co.uk>
In-Reply-To: <20020523011519.GA8521@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 03:15:19AM +0200, Anders Gustafsson wrote:
> Hi,
>
> I have started cleaning up lvm.

I started a similar process last summer, if you want to pick up on my
work you can find it in cvs under that tag 'experimental' (cvs co -d
:pserver:cvs@tech.sistina.com:/data/cvs -r experimental LVM).  There
are a *lot* of changes in there, particualarly I factored out the
ioctl interface into a file of its own and rewrote a lot of it.  I
think I tidied up the mapping functions a lot too.

However it soon became apparent that the end result would still be
poor due to the appalling ioctl interface.  Hence the LVM2 project,
which the team has been working on for the last 9 months.  So maybe
the question should be 'is it time to switch from LVM1 to LVM2 in
2.5?'.

Just so that you are aware that no matter how much you tidy up LVM1
people are not going to be happy with it - you have to compete against
flawed design as well as bad code.

- Joe
