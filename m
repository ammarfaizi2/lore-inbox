Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263974AbUDQNqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 09:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUDQNqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 09:46:43 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:57252 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263974AbUDQNql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 09:46:41 -0400
Date: Sat, 17 Apr 2004 09:20:28 -0400
From: Ben Collins <bcollins@debian.org>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux on UltraSparcII E450
Message-ID: <20040417132027.GE3647@phunnypharm.org>
References: <20040417105303.7936e413@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417105303.7936e413@vaio.gigerstyle.ch>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 10:53:03AM +0200, Marc Giger wrote:
> Hi All,
> 
> Last week I had the honor to install Linux on a E450 with 2 cpu's. All
> went fine at first. Long compiling sessions were no problem for the
> machine. Later we installed 16 additional SCSI disks and we built 
> 4 x Soft-RAID5 groups with 4 disks each.
> After some time during the sync processes the machine stops responding.
> Simply dead. The same thing happens after every boot when the sync
> process is in action.
> 
> My question now is: Is it a hardware or a kernel problem? I now it isn't
> a simple question with the given infos.
> Is it possible that the 4 parallel sync processes are to much for the
> SCSI (standard LSI) controllers?
> I assume that the kernel RAID5 code is stable on sparc?!

Try enabling some debug, like spinlock debug and such. See if that spits
out anything interesting.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
