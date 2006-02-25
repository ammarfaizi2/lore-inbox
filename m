Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWBYJJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWBYJJd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 04:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWBYJJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 04:09:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31504 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932625AbWBYJJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 04:09:33 -0500
Date: Sat, 25 Feb 2006 09:09:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225090927.GA28552@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, mpm@selenic.com,
	linux-kernel@vger.kernel.org
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225085541.GB27538@flint.arm.linux.org.uk> <20060225010436.0a948049.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225010436.0a948049.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 01:04:36AM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > FYI, here's the bk delta which introduced this fix.
> > 
> >  http://linux.bkbits.net:8080/linux-2.6/diffs/lib/inflate.c@1.6?nav=index.html|src/.|src/lib|hist/lib/inflate.c
> > 
> >  Of course, not having per-file comments in BK means that we can't get
> >  at the cset comments which explain _why_ it is necessary.  Maybe akpm
> >  keeps an archive of such things?
> 
> It's easier to just google for well-chosen hunks of the patch.
> 
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4615.html

Ah, thanks.  I eventually found my original mail which gives a full
description of the problem:

http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
