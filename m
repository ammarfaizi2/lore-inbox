Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274907AbTHABIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 21:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274910AbTHABIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 21:08:15 -0400
Received: from mail.msi.umn.edu ([128.101.190.10]:59335 "EHLO mail.msi.umn.edu")
	by vger.kernel.org with ESMTP id S274907AbTHABIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 21:08:14 -0400
Date: Thu, 31 Jul 2003 20:08:13 -0500
From: Michael Bakos <bakhos@msi.umn.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
In-Reply-To: <20030731145954.47d6247f.akpm@osdl.org>
Message-ID: <Pine.SGI.4.33.0307312007190.23301-100000@ir12.msi.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch (2.6.0-test2-mm2) did fix the asm/local.h missing file problem,
but I'm getting another one.
















> Michael Bakos <bakhos@msi.umn.edu> wrote:
> >
> > Kernel version: 2.6.0-test2
> > CPU type: x86-64 (Opteron)
> > Problem: Can not successfuly do: make bzImage
> >
> > For process.c:
> > It says that the file asm/local.h is missing, and errors out in module.h
> > at line 175, parse error before local_t
>
> Try test-2-mm2: it has the x86_64 update.
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm2/2.6.0-test2-mm2.bz2
>

