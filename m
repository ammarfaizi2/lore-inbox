Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753691AbWKDTjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbWKDTjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbWKDTjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:39:31 -0500
Received: from nsm.pl ([195.34.211.229]:29141 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1753690AbWKDTja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:39:30 -0500
Date: Sat, 4 Nov 2006 20:39:16 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061104193916.GA11717@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <454A76CC.6030003@cosmosbay.com> <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 07:40:13PM +0100, Mikulas Patocka wrote:
> >The problem with a per_cpu biglock is that you may consume a lot of RAM 
> >for big NR_CPUS. Count 32 KB per 'biglock' if NR_CPUS=1024
> 
> Does one Linux kernel run on system with 1024 cpus? I guess it must fry 
> spinlocks... (or even lockup due to spinlock livelocks)

  SGI Altix systems comes to mind. I believe that Itanium even comes in
dual core flavor, that would give 2048 CPUs.

-- 
Tomasz Torcz                                                       72->|   80->|
zdzichu@irc.-nie.spam-.pl                                          72->|   80->|

