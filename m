Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422816AbWI2Ual@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422816AbWI2Ual (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWI2Ual
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:30:41 -0400
Received: from xenotime.net ([66.160.160.81]:30119 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932366AbWI2Uak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:30:40 -0400
Date: Fri, 29 Sep 2006 13:32:05 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Zach Brown <zab@zabbo.net>
Cc: Roger Gammans <roger@computer-surgery.co.uk>,
       lkml <linux-kernel@vger.kernel.org>, axboe@kernel.dk
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-Id: <20060929133205.19c318cb.rdunlap@xenotime.net>
In-Reply-To: <451D808A.9050005@zabbo.net>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk>
	<20060929113814.db87b8d5.rdunlap@xenotime.net>
	<20060928185820.GB4759@julia.computer-surgery.co.uk>
	<20060929121157.0258883f.rdunlap@xenotime.net>
	<20060928191946.GC4759@julia.computer-surgery.co.uk>
	<20060929123737.ec613178.rdunlap@xenotime.net>
	<20060928195627.GD4759@julia.computer-surgery.co.uk>
	<20060929131730.0b733137.rdunlap@xenotime.net>
	<451D808A.9050005@zabbo.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 13:22:34 -0700 Zach Brown wrote:

> 
> > 	sector_t		bi_sector;	/* block layer sector
> > 						 * addresses are always in
> > 						 * 512-byte units in Linux */
> 
> How about adding kerneldoc for sector_t itself?

Good idea, but afaik it would have to be added for the entire
struct, not just one field.

---
~Randy
