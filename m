Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275267AbTHGKBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275271AbTHGKBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:01:23 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:54711 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S275267AbTHGKBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:01:22 -0400
Date: Thu, 7 Aug 2003 12:01:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: cb-lkml@fish.zetnet.co.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disk priority dependend on nice level...
Message-ID: <20030807100104.GA166@elf.ucw.cz>
References: <20030806232810.GA1623@elf.ucw.cz> <20030807055754.GP7982@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807055754.GP7982@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
> > but it compiles ;-).
> 
> This wont do much, you might as well forget it. Disk priorities is far
> more work than you appear to think :)

This was not my patch, I only ported it.

I'm not heading for "perfect" disk priorities (not now :-), but having
something with at least measurable effect would be nice.

For a start "niced processes get starved during I/O" should do the
trick. (And it would help my lingvistics workloads).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
