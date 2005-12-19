Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVLSMHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVLSMHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 07:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVLSMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 07:07:16 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:6669 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932446AbVLSMHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 07:07:15 -0500
Date: Mon, 19 Dec 2005 12:07:09 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: namespace pollution: dump_regs() -> elf_dump_regs()
In-Reply-To: <20051216224047.GE27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64N.0512191159440.23348@blysk.ds.pg.gda.pl>
References: <20051216224047.GE27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2005, Al Viro wrote:

> dump_regs() is used by a bunch of drivers for their internal stuff;
> renamed mips instance (one that is seen in system-wide headers)
> to elf_dump_regs()

 I guess drivers should be fixed not to use generic names in the first 
place -> s/dump_regs/frobnicator_dump_regs/, etc.

  Maciej
