Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUGLRuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUGLRuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUGLRuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:50:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21707 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265250AbUGLRtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:49:47 -0400
Date: Sat, 10 Jul 2004 14:34:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@suse.cz>,
       Christoph Hellwig <hch@infradead.org>, Erik Rigtorp <erik@rigtorp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040710123422.GC607@openzaurus.ucw.cz>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz> <20040708225501.GA20143@infradead.org> <20040709051528.GB23152@elf.ucw.cz> <20040709115531.GA28343@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709115531.GA28343@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > But I guess swsusp is going to make this more "interesting" as
>  > progressbar is nice to have there, and userland can not help at that
>  > point.
> 
> Personally I'd prefer the effort went into making suspend actually
> work on more machines rather than painting eyecandy for the minority
> of machines it currently works on.

Actually, it does work on most of UP/IDE machines by now.
Remaining problems tend to be unsupported drivers. I can't help
with devices I do not have, unfortunately, so there's little I can do.

I'm working on smp support just now... But some progress indication is
must have in future - we had people going "ouch I thought it is stuck"
when they in fact needed to wait 30seconds.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

