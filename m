Return-Path: <linux-kernel-owner+w=401wt.eu-S1161208AbXAMDYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbXAMDYU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbXAMDYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:24:20 -0500
Received: from cantor2.suse.de ([195.135.220.15]:46561 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161203AbXAMDYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:24:19 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20070113011159.9449.4327.sendpatchset@linux.site>
Subject: [patch 0/10] buffered write deadlock fix
Date: Sat, 13 Jan 2007 04:24:15 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches attempt to fix the buffered write
locking problems (and there are a couple of peripheral patches
and cleanups there too).

This does pass the write deadlock tests that otherwise fail.

Has survived a few hours of fsx-linux on ext2 and 3.

Patches against 2.6.20-rc4. I didn't have the heart to attempt
to rebase them on -mm, at least until I get some feedback ;)

Thanks,
Nick

--
SuSE Labs

