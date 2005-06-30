Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263042AbVF3UUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbVF3UUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbVF3URj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:17:39 -0400
Received: from spieleck.de ([217.197.84.238]:9224 "EHLO spieleck.de")
	by vger.kernel.org with ESMTP id S263042AbVF3TuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:50:01 -0400
Date: Thu, 30 Jun 2005 21:49:54 +0200
From: Stefan Seyfried <seife@gmane0305.slipkontur.de>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Message-ID: <20050630194954.GA20844@message-id.s3e.de>
References: <200506300042.22255.fedor@karpelevitch.net> <20050630084426.GA30436@message-id.gmane0305.slipkontur.de> <200506300618.15109.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506300618.15109.fedor@karpelevitch.net>
X-Operating-System: SuSE Linux 9.3 (i586), Kernel 2.6.11.4-21.7-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 06:18:13AM -0700, Fedor Karpelevitch wrote:
> Stefan Seyfried wrote:
> > On Thu, Jun 30, 2005 at 12:42:19AM -0700, Fedor Karpelevitch wrote:
> > > I tried to upgrade memory on my laptop from 2 x 128m by replacing

> > Did you override your DSDT?
> 
> Yes, I did.

So you need to modify your _new_ _original_ DSDT again after the memory
upgrade.
AFAIK the DSDT contains numbers that depend on the amount of memory and
is often built dynamically by the BIOS => even changing some BIOS settings
may change the DSDT.
-- 
Stefan Seyfried
