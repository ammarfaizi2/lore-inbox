Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRDGS7C>; Sat, 7 Apr 2001 14:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDGS6w>; Sat, 7 Apr 2001 14:58:52 -0400
Received: from jalon.able.es ([212.97.163.2]:40631 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129624AbRDGS6n>;
	Sat, 7 Apr 2001 14:58:43 -0400
Date: Sat, 7 Apr 2001 20:58:34 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx 6.1.10 breaks 2.4.3-ac3
Message-ID: <20010407205834.A2606@werewolf.able.es>
In-Reply-To: <20010407162835.A18620@werewolf.able.es> <200104071601.f37G18s88014@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200104071601.f37G18s88014@aslan.scsiguy.com>; from gibbs@scsiguy.com on Sat, Apr 07, 2001 at 18:01:08 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.07 Justin T. Gibbs wrote:
> 
> That's not a sufficient way to upgrade.  The tar files are there for
> people who are porting the driver to other platforms.  You should always
> use the patches to upgrade as they often touch other portions of the
> Linux kernel that need fixes in order to work correctly with the
> aic7xxx driver.
> 
> >6.1.10 just stops after the init messages and stays there forever.
> 
> To be expected as you didn't apply the patch to scsi_lib.c that makes
> scsi_unblock_host() actually run the device queues to start the system
> back up again.
>

There is no patch for 2.4.3-ac3. You could say, well if you want 6.1.10,
use plain 2.4.3.
That is not the way to do things. It is supposed that what people can get
at your site is the aic driver. If the patch contains something different,
from the tarball, nobody knows.

If there is a bug in kernel, please mail it to lkml.
And in your site make VERY clear and independent the patch to correct
that thing in main SCSI subsystem from the patch to upgrade your drivers.

> I'm working on an html page for my site that should explain all of
> the upgrade proceedures.
> 

Good idea.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

