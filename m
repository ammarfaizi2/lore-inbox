Return-Path: <linux-kernel-owner+w=401wt.eu-S932095AbXAFTOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXAFTOZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbXAFTOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:14:25 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36247 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095AbXAFTOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:14:23 -0500
Date: Sat, 6 Jan 2007 11:14:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - reiser4-sb_sync_inodes.patch causes boot hang
Message-Id: <20070106111421.457e2ad2.akpm@osdl.org>
In-Reply-To: <200701061520.l06FKntg003207@turing-police.cc.vt.edu>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701061520.l06FKntg003207@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2007 10:20:49 -0500
Valdis.Kletnieks@vt.edu wrote:

> On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> 
> reiser4-sb_sync_inodes.patch causes my system to lock hard (no alt-sysrq,
> need to power cycle) *very* early in the boot - earlyprintk hasn't fired
> up yet, I don't get penguins, *nada*. I'm guessing it's something to do with
> the changed spinlocking from the -rc2-mm1 version.

Yeah, that's an akpm screwup, sorry.

Take a peek in
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/hot-fixes/
