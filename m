Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWBYJGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWBYJGB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 04:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWBYJGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 04:06:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932625AbWBYJF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 04:05:59 -0500
Date: Sat, 25 Feb 2006 01:04:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-Id: <20060225010436.0a948049.akpm@osdl.org>
In-Reply-To: <20060225085541.GB27538@flint.arm.linux.org.uk>
References: <0.399206195@selenic.com>
	<4.399206195@selenic.com>
	<20060224221909.GD28855@flint.arm.linux.org.uk>
	<20060225065136.GH13116@waste.org>
	<20060225084955.GA27538@flint.arm.linux.org.uk>
	<20060225085541.GB27538@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> FYI, here's the bk delta which introduced this fix.
> 
>  http://linux.bkbits.net:8080/linux-2.6/diffs/lib/inflate.c@1.6?nav=index.html|src/.|src/lib|hist/lib/inflate.c
> 
>  Of course, not having per-file comments in BK means that we can't get
>  at the cset comments which explain _why_ it is necessary.  Maybe akpm
>  keeps an archive of such things?

It's easier to just google for well-chosen hunks of the patch.

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4615.html
