Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262940AbTCSIBu>; Wed, 19 Mar 2003 03:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262943AbTCSIBu>; Wed, 19 Mar 2003 03:01:50 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:59778 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262940AbTCSIBt>;
	Wed, 19 Mar 2003 03:01:49 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm1
References: <20030318031104.13fb34cc.akpm@digeo.com>
	<87adfs4sqk.fsf@lapper.ihatent.com>
	<87bs08vfkg.fsf@lapper.ihatent.com>
	<20030318160902.C21945@flint.arm.linux.org.uk>
	<873clkw6ui.fsf@lapper.ihatent.com>
	<20030318162601.78f11739.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Mar 2003 09:12:48 +0100
In-Reply-To: <20030318162601.78f11739.akpm@digeo.com>
Message-ID: <87fzpjepvj.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > I'm not suspecting the PCI in particular for the PCIC-bits, only
> > making X and the Radeon work again. But here you are:
> 
> Something bad has happened to the Radeon driver in recent kernels.  I've seen
> various reports with various syptoms and some suspicion has been directed at
> the AGP changes.
> 
> But as far as I know nobody has actually got down and done the binary search
> to find out exactly when it started happening.

Just got my machine out and booted up, this time I did enable my
chipset into 4x AGP, instead of 1x as last night:

alexh@lapper ~ $ dmesg | grep -i agp
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i845 chipset
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 256M @ 0xa0000000
agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
alexh@lapper ~ $

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
