Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUHPOrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUHPOrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267658AbUHPOrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:47:07 -0400
Received: from math.ut.ee ([193.40.5.125]:53225 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S267651AbUHPOrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:47:05 -0400
Date: Mon, 16 Aug 2004 17:39:19 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: How to debug 2.6 PReP boot hang?
In-Reply-To: <20040729225559.GJ16468@smtp.west.cox.net>
Message-ID: <Pine.GSO.4.44.0408161729570.5336-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My suggestion is to go back in releases until one does work, see where
> the changes are that break it, and work from there.  It should be
> possible to fix what broke. :)

OK, did some compiling and testing and fout that my suspicion was right:
BK changeset 1.1371.384.5 boots ok but 1.1371.384.6 makes it hang.

It's the one that reorganizes boot code:
PPC32: Kill off arch/ppc/boot/prep and rearrange some files.

-- 
Meelis Roos (mroos@linux.ee)

