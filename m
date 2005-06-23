Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVFWSsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVFWSsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVFWSoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:44:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30154 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263036AbVFWSlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:41:22 -0400
Date: Thu, 23 Jun 2005 20:42:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP+irq handling broken in current git?
Message-ID: <20050623184234.GE9768@suse.de>
References: <20050623135318.GC9768@suse.de> <42BAEA67.7090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BAEA67.7090606@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >Something strange is going on with current git as of this morning (head
> >ee98689be1b054897ff17655008c3048fe88be94). On an old test box (dual p3
> >800MHz), using the same old config I always do on this box has very
> >broken interrupt handling:
> 
> Does 2.6.12 work for you?
> 2.6.11?

2.6.11 works, 2.6.12 does not.


> I noticed a few "2.6.12 is broken, 2.6.11 works" bug reports with 
> vaguely similar circumstances -- irq handling being a culprit.

One boot kept looping with screaming floppy interrupts, so something has
gone really bad there.

-- 
Jens Axboe

