Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVBPPdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVBPPdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVBPPdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:33:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3545 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262043AbVBPPdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:33:40 -0500
Date: Wed, 16 Feb 2005 16:33:41 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
Message-ID: <20050216153338.GA26953@atrey.karlin.mff.cuni.cz>
References: <20050215145618.GP24211@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215145618.GP24211@charite.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Today our mailserver froze after just one day of uptime. I was able to
> capture the Oops on the screen using my digital camera:
> 
> http://www.stahl.bau.tu-bs.de/~hildeb/bugreport/
> 
> Keywords: EIP is at journal_commit_transaction, process kjournald
  I guess the system is SMP... Sadly a few lines in the beginning of the
report are missing (probably scrolled off the screen) but it seems
similar like a several other oopses I've seen reported recently. Is this
the first time you hit this bug?

> # mount
> /dev/cciss/c0d0p6 on / type ext3 (rw,errors=remount-ro)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/cciss/c0d0p5 on /boot type ext3 (rw)
> /dev/shm on /var/amavis type tmpfs (rw,noatime,size=200m,mode=770,uid=104,gid=108)

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
