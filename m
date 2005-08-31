Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbVIAPE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVIAPE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVIAPE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:04:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46773 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965180AbVIAPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:04:55 -0400
Date: Wed, 31 Aug 2005 20:56:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap areas lose their signatures after reboot
Message-ID: <20050831185604.GF703@openzaurus.ucw.cz>
References: <20050830142615.12910b57.Christoph.Pleger@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830142615.12910b57.Christoph.Pleger@uni-dortmund.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We have a machine with much RAM and 4 SCSI disks. We want to have 8 GB
> of Swap space. So I partitioned the hard disks with one swap partition
> of 2GB on every disk. But only the swap partition of the first disk can
> be used after a reboot; the other three swap partitions lose their swap
> signature.
> 
> When I call "swapon -a" manually, it says "Invalid argument" for these
> three partitions. After executing "mkswap" on them, "swapon -a" works
> fine. But I have to call "mkswap" after every reboot.
> 
> What happens with the swap signatures during reboot?

swsusp plays with them... Are you using swsusp?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

