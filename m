Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbSIYArc>; Tue, 24 Sep 2002 20:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261865AbSIYArc>; Tue, 24 Sep 2002 20:47:32 -0400
Received: from p508B52D6.dip.t-dialin.net ([80.139.82.214]:51916 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S261862AbSIYArb>; Tue, 24 Sep 2002 20:47:31 -0400
Date: Wed, 25 Sep 2002 02:52:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Conserving memory for an embedded application
Message-ID: <20020925025237.A30316@linux-mips.org>
References: <3D91413C.1050603@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D91413C.1050603@goingware.com>; from crawford@goingware.com on Wed, Sep 25, 2002 at 12:53:16AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 12:53:16AM -0400, Michael D. Crawford wrote:

> on.  An important concern is to minimize the amount of ROM and flash ram that 
> the device has, both to save manufacturing cost and to minimize power consumption.
> 
> One question I have is whether it is possible to burn an uncompressed image of 
> the kernel into flash, and then boot the kernel in-place, so that it is not 
> copied to RAM when it runs.  Of course the kernel would need RAM for its data 
> structures and user programs, but it would seem to me I should be able to run 
> the kernel without making a RAM copy.

Flash is much slower than normal memory so if you want any performance
beyond the level of Eniac I suggest to copy it to RAM ...

> don't think the user program would be very large.
> 
> Also, what is the minimum amount of physical ram that you think I can get any 
> version of the kernel later than 2.0 or so to run in?  I heard somewhere that 
> someone can boot an x86 system with as little as 2MB of RAM.  Is that the case?

That's rather old kernels and also heavily hacked.

  Ralf
