Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263316AbTDCIUn>; Thu, 3 Apr 2003 03:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263301AbTDCIUn>; Thu, 3 Apr 2003 03:20:43 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:21503
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263269AbTDCIUl>; Thu, 3 Apr 2003 03:20:41 -0500
Date: Thu, 3 Apr 2003 03:27:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "" <linux-scsi@vger.kernel.org>
Subject: Re: isp1020 memory trample in 2.5.66
In-Reply-To: <20030402080226.A25288@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.50.0304030317230.30262-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304020101460.8773-100000@montezuma.mastecende.com>
 <20030402080226.A25288@beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Patrick Mansfield wrote:

> I've been booting OK with 2.5.66 with isp1020 and qlogicisp driver with
> multiple disks, though the boot sometimes hangs.
> 
> I've also booted OK with the feral driver.

I'll be prepping a kernel with that.

> This looks a lot like the oops when trying to send IO to more than one
> disk at a time with the isp1020 + qlogicisp.
> 
> Is there something different causing IO to muliple disks at that point?

Yes it is possible as i have another disk on the same HBA with /usr

> I hit this once when I enabled parallel fsck (it didn't oops until after I
> got a late oops, and rebooted).
> 
> Martin hit it when the queue depth was not properly checked.
> 
> wli has hit it with parallel mkfs (or something).

Ok this thing sounds _very_ fragile ;)

> The following thread was pretty useful, Doug L mentions that the qlogicisp
> does bad things, starting with Martin's analysis:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104457083601573&w=2

Thanks! that looks very familiar.

	Zwane
-- 
function.linuxpower.ca
