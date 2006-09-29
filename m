Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWI2UWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWI2UWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWI2UWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:22:37 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:60829 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1422808AbWI2UWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:22:36 -0400
Message-ID: <451D808A.9050005@zabbo.net>
Date: Fri, 29 Sep 2006 13:22:34 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Roger Gammans <roger@computer-surgery.co.uk>,
       lkml <linux-kernel@vger.kernel.org>, axboe@kernel.dk
Subject: Re: fs/bio.c - Hardcoded sector size ?
References: <20060928182238.GA4759@julia.computer-surgery.co.uk>	<20060929113814.db87b8d5.rdunlap@xenotime.net>	<20060928185820.GB4759@julia.computer-surgery.co.uk>	<20060929121157.0258883f.rdunlap@xenotime.net>	<20060928191946.GC4759@julia.computer-surgery.co.uk>	<20060929123737.ec613178.rdunlap@xenotime.net>	<20060928195627.GD4759@julia.computer-surgery.co.uk> <20060929131730.0b733137.rdunlap@xenotime.net>
In-Reply-To: <20060929131730.0b733137.rdunlap@xenotime.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	sector_t		bi_sector;	/* block layer sector
> 						 * addresses are always in
> 						 * 512-byte units in Linux */

How about adding kerneldoc for sector_t itself?

- z
