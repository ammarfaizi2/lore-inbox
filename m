Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSH0VFF>; Tue, 27 Aug 2002 17:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSH0VEb>; Tue, 27 Aug 2002 17:04:31 -0400
Received: from [195.39.17.254] ([195.39.17.254]:18560 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318376AbSH0VDQ>;
	Tue, 27 Aug 2002 17:03:16 -0400
Date: Tue, 27 Aug 2002 15:23:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: Peter Chubb <peter@chubb.wattle.id.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20020827152303.L35@toy.ucw.cz>
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <20020823070759.GS19435@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020823070759.GS19435@clusterfs.com>; from adilger@clusterfs.com on Fri, Aug 23, 2002 at 01:07:59AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Then the following works properly without ugly casts or warnings:
> 
> 	__u64 val = 1;
> 
> 	printk("at least "PFU64" of your u64s are belong to us\n", val);

Casts are ugly but this looks even worse. I'd go for casts.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

