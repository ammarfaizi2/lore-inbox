Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUA3SGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUA3SGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:06:54 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:47082 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S262228AbUA3SGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:06:52 -0500
Subject: Re: 2.6.2-rc2-mm2
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040130092739.0700caff.akpm@osdl.org>
References: <1jDrO-4xh-13@gated-at.bofh.it>
	 <m3d691n14e.fsf@terminal124.gozu.lan>
	 <20040130092739.0700caff.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1075486007.3470.3.camel@terminal124.gozu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 19:06:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-30 at 18:27, Andrew Morton wrote:
> s864@ii.uib.no (Ronny V. Vindenes) wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm2/
> > > 
> > > 
> > > - I added a few late-arriving patches.  Usually this breaks things.
> > > 
> > 
> > I got a reject in include/linux/sched.h,
> 
> yes, sorry about that.  I uploaded a new 2.6.2-rc2-mm2-1.gz
> 
> > it still compiles but doesn't boot,
> > the harddisks (2 sata + a pata) makes some wierd noises but no signs
> > of booting. -mm1 works fine (with the futex debug patch reverted).
> 
> I don't know what could be the cause of that.  You could check those config
> optons and do a `make clean'.

Not quite sure what went wrong but /boot was 99% full. Cleared up some
space and reinstalled and everything booted normal.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

