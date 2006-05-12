Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWELLrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWELLrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWELLrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:47:04 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:45762 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751241AbWELLrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:47:01 -0400
Date: Fri, 12 May 2006 13:47:00 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Michael Buesch <mb@bu3sch.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.17-rc4
Message-ID: <20060512114659.GE30285@harddisk-recovery.com>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <20060512102422.GA30285@harddisk-recovery.com> <200605121244.22511.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605121244.22511.mb@bu3sch.de>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 12:44:22PM +0200, Michael Buesch wrote:
> On Friday 12 May 2006 12:24, you wrote:
> > On Thu, May 11, 2006 at 04:44:03PM -0700, Linus Torvalds wrote:
> > > Ok, I've let the release time between -rc's slide a bit too much again, 
> > > but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> > > 
> > > If you know of any regressions, please holler now, so that we don't miss 
> > > them. 
> > 
> > I got assertion failures in the bcm43xx driver:
> > 
> > bcm43xx: Chip ID 0x4318, rev 0x2
> 
> That is expected an non-fatal.

Assertion failed sounds rather fatal to me.

> It is no regression.

It is, I didn't see it in 2.6.17-rc3.

> We are working on it, but there won't be any fix for 2.6.17, as
> very intrusive changes are needed to fix this.

If it's non-fatal, could you remove the assertion, or make it print
something that sounds less fatal?


Erik


-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
