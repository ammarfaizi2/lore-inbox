Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbTE1SjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbTE1SjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:39:20 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:63105 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S264825AbTE1SjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:39:19 -0400
Message-Id: <200305281852.h4SIqWHJ015026@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: berrymount.save/customers/marvel/compulead
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 bug: fifo-write causes diskwrites to read-only fs ! 
In-Reply-To: Message from Rob van Nieuwkerk <robn@verdi.et.tudelft.nl> 
   of "Wed, 28 May 2003 19:58:42 +0200." <20030528175842.GA13657@verdi.et.tudelft.nl> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 28 May 2003 20:52:32 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote:
> It turns out that Linux is updating inode timestamps of fifos (named
> pipes) that are written to while residing on a read-only filesystem.
> It is not only updating in-ram info, but it will issue *physical*
> writes to the read-only fs on the disk !
	.
	.
	.
> Sysinfo:
> --------
> - various 2.4 kernels including RH-2.4.20-13.9,
>   but also straight 2.4(ac) ones.
> - CompactFlash (= IDE disk)
> - Geode GX1 CPU (i586 compatible)

Forgot to mention: I use an ext2 fs, but maybe it's a generic,
fs-independant problem.

	greetings,
	Rob van Nieuwkerk
