Return-Path: <linux-kernel-owner+w=401wt.eu-S1762648AbWLKIZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762648AbWLKIZs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 03:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762650AbWLKIZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 03:25:48 -0500
Received: from brick.kernel.dk ([62.242.22.158]:24953 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762648AbWLKIZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 03:25:47 -0500
Date: Mon, 11 Dec 2006 09:26:58 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Pavel Machek <pavel@ucw.cz>, Christoph Schmid <chris@schlagmichtod.de>,
       linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Message-ID: <20061211082658.GF4576@kernel.dk>
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it> <7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local> <20061130171910.GD1860@elf.ucw.cz> <87k61bpuk4.fsf@denkblock.local> <20061202115709.GC4030@ucw.cz> <87wt50wokd.fsf@denkblock.local> <87psaswnxp.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psaswnxp.fsf@denkblock.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10 2006, Elias Oltmanns wrote:
> Hi Jens,
> 
> Elias Oltmanns <eo@nebensachen.de> wrote:
> > So, here is a patch in which your remarks and suggestions have been
> > incorporated. Additionally, I've added the requested kernel doc file
> > and another sysfs attribute called protect_method. The usage of this
> > attribute is described in Documentation/block/disk-protection.txt.
> 
> Just forgot to mention that your suggestions haven't been implemented
> yet. Thats because I'm only gradually beginning to understand the
> reasoning and how it might work out in the end. It will probably take
> me another weekend (or more) to come up with something fit for
> discussion. Bare with me, I'm rather busy at the moment and still new
> to the block layer (or kernel code, for that matter).

No worries, take your time. The target for the code wont be 2.6.20
anyways, so you have at least a month to get things designed right and
solid for a 2.6.21 target.

-- 
Jens Axboe

