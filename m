Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262869AbSJAWTv>; Tue, 1 Oct 2002 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbSJAWTu>; Tue, 1 Oct 2002 18:19:50 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17156 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262869AbSJAWSh>;
	Tue, 1 Oct 2002 18:18:37 -0400
Date: Mon, 30 Sep 2002 00:38:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Conserving memory for an embedded application
Message-ID: <20020930003822.A35@toy.ucw.cz>
References: <3D9156E6.1030703@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D9156E6.1030703@snapgear.com>; from gerg@snapgear.com on Wed, Sep 25, 2002 at 04:25:42PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> One question I have is whether it is possible to burn an uncompressed image
> >> of the kernel into flash, and then boot the kernel in-place, so that it is
> >> not copied to RAM when it runs.  Of course the kernel would need RAM for
> >> its data structures and user programs, but it would seem to me I should be
> >> able to run the kernel without making a RAM copy.
> > The uclinux guys have eXecute In Place  - google search for uclinux and XIP 
> > will produce a stack of hits - here's one:
> > http://www.snapgear.com/tb20010618.html
> 
> Yep, we have this for uClinux. Currently we are only doing
> this on MMU-less processors though, I haven't heard of anyone
> doing kernel (or apps) XIP from flash on VM processors.

I thought they were doing XIP on VTechHelio? That's MIPS39xx and has MMU.
See linux-vr project.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

