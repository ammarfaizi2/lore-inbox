Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbTC1R5V>; Fri, 28 Mar 2003 12:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263079AbTC1R5V>; Fri, 28 Mar 2003 12:57:21 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:8936 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S263077AbTC1R5U>; Fri, 28 Mar 2003 12:57:20 -0500
Date: Fri, 28 Mar 2003 10:05:50 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030328180545.GG32000@ca-server1.us.oracle.com>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com> <Pine.LNX.4.44.0303281031120.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303281031120.5042-100000@serv>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 10:47:14AM +0100, Roman Zippel wrote:
> On Thu, 27 Mar 2003, Greg KH wrote:
> > They point and guess, just like they do today :)
> 
> I think the users which need this most won't be particular happy.

	I represent the users which need this most, and I an tell you we
will be 100x happier pointing and guessing at enough dev_t space.  If we
were to have to stick with the ancient, serously outdated limits of the
current space, we will be terribly unhappy.
	Not having the perfect solution all at once doesn't mean you do
nothing.  The size of dev_t is orthogonal to device naming.  Once this
is in, the current device naming (however poor it is) can handle the
number of devices we need.  Future device naming strategies (like the
one Greg is working on) will work with a large dev_t just fine.

Joel

-- 

"Vote early and vote often." 
        - Al Capone

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
