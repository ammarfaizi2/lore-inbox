Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUGHUvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUGHUvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 16:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUGHUvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 16:51:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20424 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265002AbUGHUvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 16:51:16 -0400
Date: Thu, 8 Jul 2004 22:48:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Hellwig <hch@infradead.org>, Erik Rigtorp <erik@rigtorp.com>,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040708204840.GB607@openzaurus.ucw.cz>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708133934.GA10997@infradead.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch adds support for bootsplash to swsusp. The code interfacing to
> > bootsplash needs some more work, currently it's more or less ripped from
> > swsusp2. Some more code could probably be moved into console.c instead.
> 
> CONFIG_BOOTSPALSH (foruntatley) isn't in mainline, so while you're of course
> free to keep this patch around it has no business at all in mainline.

The patch was not intended for mainline... But it will be usefull anyway as big distros
want this kind of stuff....

Perhaps CONFIG_BOOTSPLASH should be in mainline after all?
I really don't want to see 2 different incompatible sets
of hooks into swsusp....
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

