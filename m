Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUDAFlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbUDAFlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:41:04 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:57553 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262285AbUDAFkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:40:55 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: [Kgdb-bugreport] Re: Latest kgdb?
Date: Thu, 1 Apr 2004 11:09:57 +0530
User-Agent: KMail/1.5
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040319162009.GE4569@smtp.west.cox.net> <20040331160806.GG220@elf.ucw.cz> <20040331161213.GJ13819@smtp.west.cox.net>
In-Reply-To: <20040331161213.GJ13819@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404011109.58270.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 Mar 2004 9:42 pm, Tom Rini wrote:
> On Wed, Mar 31, 2004 at 06:08:06PM +0200, Pavel Machek wrote:
> > Hi!
> >
> > > > Where can I get latest kgdb? The version on kgdb.sf.net is still
> > > > against 2.6.3, afaics. Or should I forward port it?
> > >
> > > CVS is against 2.6.4.  Once 2.6.5 comes out, I'll move it forward
> > > again. Locally, I've got a series of patches vs 2.6.5-rc3 + some -mm
> > > bits for Andrew which I hope to post today, but might not make it until
> > > tomorrow.
> >
> > Okay, CVS *is* against 2.6.4, but it says it is against 2.6.3. Okay to
> > commit?
> > 								Pavel
> > Index: README
> > ===================================================================
> > RCS file: /cvsroot/kgdb/kgdb-2/README,v
> > retrieving revision 1.5
> > diff -u -u -r1.5 README
> > --- README	2 Mar 2004 11:10:36 -0000	1.5
> > +++ README	31 Mar 2004 15:52:54 -0000
> > @@ -1,4 +1,4 @@
> > -Base Kernel version: 2.6.3
> > +Base Kernel version: 2.6.4
> >
> >  Patch:
> >  ------
> > @@ -39,8 +39,8 @@
> >  Supply command line options kgdbwait and kgdb8250 to the kernel.
> >  Example:  kgdbwait kgdb8250=0,115200
> >  (for ttyS0), then
> > -   % stty 115200 < /dev/ttyS0
> >     % gdb ./vmlinux
> > +   (gdb) set remotebaud 115200
> >     (gdb) target remote /dev/ttyS0
> >
> >  Example for kgdb ethernet interface
>
> Sure.

Yes. We have to keep that in mind. This has happened second time.
Thanks, Pavel.

-Amit

