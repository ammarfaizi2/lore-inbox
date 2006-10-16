Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWJPOFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWJPOFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWJPOFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:05:21 -0400
Received: from ns.suse.de ([195.135.220.2]:47760 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750815AbWJPOFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:05:20 -0400
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/i386: ioremap balanced with iounmap
References: <1160368320.19143.207.camel@amol.verismonetworks.com>
From: Andi Kleen <ak@suse.de>
Date: 16 Oct 2006 16:05:06 +0200
In-Reply-To: <1160368320.19143.207.camel@amol.verismonetworks.com>
Message-ID: <p73fydocq5p.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amol Lad <amol@verismonetworks.com> writes:

> ioremap must be balanced by an iounmap and failing to do so can result
> in a memory leak.
> 
> Tested (compilation only):
> - using allmodconfig
> - making sure the files are compiling without any warning/error due to
> new changes
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>

Can you please submit individual patches to the respective maintainers?

-Andi
