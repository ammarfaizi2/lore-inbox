Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUCRQT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbUCRQT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:19:57 -0500
Received: from smtp.freestart.hu ([213.197.64.6]:60938 "EHLO
	relay.freestart.hu") by vger.kernel.org with ESMTP id S262741AbUCRQTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:19:51 -0500
Date: Thu, 18 Mar 2004 17:16:55 +0100 (CET)
From: "Peter S. Mazinger" <ps.m@gmx.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.25-rc1: attempt to access beyond end of device
In-Reply-To: <Pine.LNX.4.44.0403011935270.9653-100000@lnx.bridge.intra>
Message-ID: <Pine.LNX.4.44.0403181711480.10225-100000@lnx.bridge.intra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-freestart-banner: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Peter S. Mazinger wrote:

I have seen 2 LKML messages related to it (IBM Serveraid and RedHat 7.3 
related)
Well I have RedHat 7.3, and when I saw the second message I have updated 
mount from 2.11n (it's the official/updated RedHat 7.3 version) to 2.12.

The "error" messages are gone. but I do not really know if the error is 
gone.

Peter

> On Fri, 27 Feb 2004, Marcelo Tosatti wrote:
> 
> > 
> > Peter,
> > 
> > Can you try to revert (apply with -R) and see if it happens again, please?
> 
> Yes, it happens again (the problem appeared at 2.4.25-pre4 time, but that 
> patch is to huge for me to find the problematic part)
> 
> Peter
> 
> > 
> > 
> > On Fri, 6 Feb 2004, Peter S. Mazinger wrote:
> > 
> > > Hello!
> > >
> > > my hardware:
> > > x86
> > > ide controller (builtin driver)
> > > ext3 partitions (as modules loaded from initrd)
> > >
> > > if I shutdown -h now the computer, I get as last messages:
> > > attempt to access beyond end of device
> > > 03:03 rw=0, want=1044228, limit=1044225
> > > (3 times, 03:03/want/limit with other numbers), for all mounted
> > > (remounted ro) partitions
> > >
> > > distro: RedHat 7.3 (with all updates up to december)
> > > kernel is pristine: only 2.4.25-rc1 applied (EXPERIMENTAL code disabled)
> > > util-linux: 2.11n-12.7.3 (used umount, if it matters)
> > >
> > > Peter
> > >
> > > --
> > > Peter S. Mazinger <ps dot m at gmx dot net>           ID: 0xA5F059F2
> > > Key fingerprint = 92A4 31E1 56BC 3D5A 2D08  BB6E C389 975E A5F0 59F2
> > >
> > >
> > > ____________________________________________________________________
> > > Miert fizetsz az internetert? Korlatlan, ingyenes internet hozzaferes a FreeStarttol.
> > > Probald ki most! http://www.freestart.hu
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> 
> 

-- 
Peter S. Mazinger <ps dot m at gmx dot net>           ID: 0xA5F059F2
Key fingerprint = 92A4 31E1 56BC 3D5A 2D08  BB6E C389 975E A5F0 59F2


____________________________________________________________________
Miert fizetsz az internetert? Korlatlan, ingyenes internet hozzaferes a FreeStarttol.
Probald ki most! http://www.freestart.hu
