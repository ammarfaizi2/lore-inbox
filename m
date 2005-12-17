Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVLQWVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVLQWVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVLQWVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:21:18 -0500
Received: from p549F55B1.dip.t-dialin.net ([84.159.85.177]:46754 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S964983AbVLQWVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:21:17 -0500
Date: Sat, 17 Dec 2005 22:20:59 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: namespace pollution: dump_regs() -> elf_dump_regs()
Message-ID: <20051217222058.GC3028@linux-mips.org>
References: <20051216224047.GE27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216224047.GE27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 10:40:47PM +0000, Al Viro wrote:

> dump_regs() is used by a bunch of drivers for their internal stuff;
> renamed mips instance (one that is seen in system-wide headers)
> to elf_dump_regs()

Applied.
