Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWAORYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWAORYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWAORYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:24:38 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:42421 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932098AbWAORYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:24:37 -0500
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com>
	<43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com>
	<43C982C0.1070605@cfl.rr.com>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jan 2006 18:24:08 +0100
In-Reply-To: <43C982C0.1070605@cfl.rr.com>
Message-ID: <m3r779z9on.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> writes:

> Peter Osterlund wrote:
>   > OK, so it appears you can make packets bigger than 64KB. Can I please
> > have those patches so I can test this myself.
> 
> Sure, patches attached.
> 
> patch-6 is the one you are interested in for the different sizes

Thanks, it seems to work just fine. I have put the overflow and zero
check changes in my kernel patch queue.

However, I want to wait with the increased max packet size until the
memory allocation strategy has been changed to avoid wasting lots of
memory in the common cases. I will go work on a patch to do that now.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
