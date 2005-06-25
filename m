Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263292AbVFYCmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbVFYCmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 22:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbVFYCmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 22:42:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30412 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263292AbVFYCmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 22:42:43 -0400
Date: Sat, 25 Jun 2005 04:42:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050625024240.GB22393@atrey.karlin.mff.cuni.cz>
References: <20050623142335.A5564@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623142335.A5564@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I hope there's no need to explain this in the email; if there is, the
> entry isn't good enough. 8)
> 
> However, wouldn't it be a good idea if this file was ordered by "when" ?
> A quick scan of the file reveals a couple of overdue/forgotten items
> (maybe they happened but the entry in the file got missed?):
> 
> What:   ACPI S4bios support
> When:   May 2005

ACPI S4bios will be killed "when convient" -- probably when we touch
/sys/power/* interface for another reason.

If there's pressure I can probably produce patch faster; I did not
forget, just S4bios did not get in my way *yet*.
							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
