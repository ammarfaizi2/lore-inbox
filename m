Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312702AbSCVG6s>; Fri, 22 Mar 2002 01:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312703AbSCVG6i>; Fri, 22 Mar 2002 01:58:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:43781 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312702AbSCVG6V>; Fri, 22 Mar 2002 01:58:21 -0500
Message-ID: <3C9AD531.C2C8C178@zip.com.au>
Date: Thu, 21 Mar 2002 22:54:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Amit S. Kale" <akale@veritas.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Hari Gadi <HGadi@ecutel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: module (kernel) debugging
In-Reply-To: <AF2378CBE7016247BC0FD5261F1EEB210B6A93@EXCHANGE01.domain.ecutel.com> <20020322000823.GD785@holomorphy.com> <3C9AD0EB.C56CE9B7@veritas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" wrote:
> 
> William Lee Irwin III wrote:
> >
> > On Thu, Mar 21, 2002 at 05:15:48PM -0500, Hari Gadi wrote:
> > > Hi,
> > > I am new to kernel level development. What are the best ways to debug
> > > runtime kernel (module). Are there any third party tools for debugging
> > > the kernel.
> >
> > http://www.arium.com
> > http://oss.sgi.com/projects/kdb
> > http://oss.sgi.com/projects/kgdb
> 
> SGI's kgdb is for 2.2 kernels only.
> kgdb for 2.4 kernels resides at http://kgdb.sourceforge.net/
> You'll find there scripts for debugging modules with kgdb.
> 

I have 2.5 kgdb stub patches too.  Various versions can be discovered
by poking around in http://www.zip.com.au/~akpm/linux/patches/

The version I use is a bit thinner than Amit's - I took out the
assertion checks from various places because they cause patching pain.
The assertion mechanism is still there, but the *uses* of it I took
out.

Of course, I may not be feature- or bugfix-current against Amit's
version.

-
