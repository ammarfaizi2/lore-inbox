Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317882AbSGPQ31>; Tue, 16 Jul 2002 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317883AbSGPQ30>; Tue, 16 Jul 2002 12:29:26 -0400
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:52849 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317882AbSGPQ3Z>; Tue, 16 Jul 2002 12:29:25 -0400
Date: Tue, 16 Jul 2002 17:31:57 +0100
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Kevin Corry <corryk@us.ibm.com>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [Announce] device-mapper beta3 (fast snapshots)
Message-ID: <20020716163157.GA11334@fib011235813.fsnet.co.uk>
References: <3D2F6464.60908@us.ibm.com> <02071513565400.06209@boiler> <20020716084234.GA431@fib011235813.fsnet.co.uk> <200207161105.49328.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207161105.49328.habanero@us.ibm.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Tue, Jul 16, 2002 at 11:05:49AM -0500, Andrew Theurer wrote:
> at 32k all the time?  That would explain why these results are flat, while I
> am getting a wider range.

I think this is a red herring, the chunk size code did accidentally
get backed out of CVS for a while.  But variable chunk sizes were
certainly going into the kernel when we did the development.

> Joe, are you absolutely sure these tests had the disk cache disabled?  That's
> the only hardware thing I can think of that would make a difference.

Absolutely sure.  Those figures were for a pair of PVs that were
sharing an IDE cable so I can certainly get things moving faster.

> It seems we can go 'round and 'round to no end, as long as we have HW
> differences, so I have asked for use on a OSDL system we can both run on.
> This way there is no difference in our HW.  I'll let you know when I hear
> back from them, so we can both test on the same system (if you want to).

Excellent idea, we should probably think up some better benchmarks too.

- Joe
